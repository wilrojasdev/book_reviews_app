import 'package:book_reviews_app/models/review.dart';
import 'package:book_reviews_app/services/firebase_services.dart';
import 'package:book_reviews_app/services/shared_preference_services.dart';
import 'package:flutter/foundation.dart';

class ReviewsViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = true;
  bool hasReview = false;
  List<Review> bookReviews = [];

  bool get isLoading => _isLoading;

  Future<void> fetchBookReviews(String bookId) async {
    try {
      _isLoading = true;
      List<Review> reviews = await _firebaseService.getReviewsByBookId(bookId);
      bookReviews = reviews;

      _checkUserLoginStatus();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching reviews: $e');
      }
    }
  }

  String currentUser = '';

  void _checkUserLoginStatus() async {
    currentUser = (await SharedPreferenceService().getUserId()) ?? "";
    if (currentUser.isNotEmpty) {
      checkIfUserHasReviewed(currentUser);
    }
  }

  Review? getReviewByUserId(String userId) {
    return bookReviews.firstWhere(
      (review) => review.userId == userId,
    );
  }

  Future<void> addReview(
      String userId, String bookId, String comment, double rating) async {
    if (rating > 0) {
      _isLoading = true;
      notifyListeners();

      try {
        Review newReview = Review(
          id: '',
          userId: userId,
          userName: '',
          bookId: bookId,
          comment: comment,
          rating: rating,
          createdAt: DateTime.now(),
        );

        await _firebaseService.addReview(newReview);

        List<Review> updatedReviews =
            await _firebaseService.getReviewsByBookId(bookId);
        bookReviews = updatedReviews;
        hasReview = true;

        _isLoading = false;
        notifyListeners();
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        if (kDebugMode) {
          print('Error adding review: $e');
        }
        throw Exception('Failed to add review');
      }
    }
  }

  void checkIfUserHasReviewed(String userId) {
    if (bookReviews.isEmpty) {
      hasReview = false;
    } else {
      hasReview = bookReviews.any((review) => review.userId == userId);
    }
  }

  Future<void> deleteReview(String reviewId, String bookId) async {
    try {
      String result = await _firebaseService.deleteReview(reviewId);

      if (result == 'Review deleted successfully') {
        hasReview = false;
        await fetchBookReviews(bookId);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred: $e');
      }
    }
  }
}
