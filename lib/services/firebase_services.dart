import 'package:book_reviews_app/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('categories').get();
      List<String> categories = [];
      for (var doc in snapshot.docs) {
        categories.add(doc['name']);
      }
      return categories;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching categories: $e');
      }
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Review>> getReviewsByBookId(String bookId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('review')
          .where('idBook', isEqualTo: bookId)
          .get();
      List<Review> reviews = snapshot.docs
          .map((doc) =>
              Review.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      return reviews;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching reviews: $e');
      }
      throw Exception('Failed to load reviews');
    }
  }

  Future<void> addReview(Review review) async {
    try {
      String userName = await getUserNameById(review.userId) ?? 'Unknow';

      DocumentReference reviewRef = _firestore.collection('review').doc();
      Review newReview = Review(
        id: reviewRef.id,
        userId: review.userId,
        userName: userName,
        bookId: review.bookId,
        comment: review.comment,
        rating: review.rating,
        createdAt: review.createdAt,
      );

      await reviewRef.set(newReview.toMap());
    } catch (e) {
      throw Exception('Failed to add review');
    }
  }

  Future<void> saveUserToFirestore(
      String email, String name, String uid) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'name': name,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error saving user to Firestore: $e');
      }
      throw Exception('Failed to save user data to Firestore');
    }
  }

  Future<String?> getUserNameById(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data()?['name'];
      } else {
        if (kDebugMode) {
          print('User with ID $userId not found.');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user name: $e');
      }
      throw Exception('Failed to fetch user name');
    }
  }

  Future<String> deleteReview(String reviewId) async {
    try {
      DocumentReference reviewRef =
          _firestore.collection('review').doc(reviewId);
      await reviewRef.delete();
      return 'Review deleted successfully';
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting review: $e');
      }
      return 'Failed to delete review';
    }
  }
}
