import 'package:book_reviews_app/models/review.dart';
import 'package:book_reviews_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ReviewsViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<Review> bookReviews = [];

  Future<void> fetchBookReviews(String bookId) async {
    try {
      List<Review> reviews = await _firebaseService.getReviewsByBookId(bookId);
      _isLoading = false;
      bookReviews = reviews;

      notifyListeners();
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }

  // Buscar reseña por userId
  Review? getReviewByUserId(String userId) {
    return bookReviews.firstWhere(
      (review) => review.userId == userId,
    );
  }

  // Método para agregar una nueva reseña
  Future<void> addReview(
      String userId, String bookId, String comment, double rating) async {
    if (rating > 0) {
      // Establecer el indicador de carga a true
      _isLoading = true;
      notifyListeners();

      try {
        // Crear una nueva reseña con la fecha actual
        Review newReview = Review(
          id: '', // El ID será generado por Firestore
          userId: userId,
          bookId: bookId,
          comment: comment,
          rating: rating,
          createdAt: DateTime.now(),
        );

        // Llamar al servicio Firebase para agregar la reseña
        await _firebaseService.addReview(newReview);

        // Obtener las reseñas actualizadas desde Firestore
        List<Review> updatedReviews =
            await _firebaseService.getReviewsByBookId(bookId);

        // Actualizar la lista de reseñas
        bookReviews = updatedReviews;
        hasReview = true;
        // Establecer el indicador de carga a false
        _isLoading = false;
        notifyListeners();
      } catch (e) {
        // En caso de error, restablecer el indicador de carga
        _isLoading = false;
        notifyListeners();
        print('Error adding review: $e');
        throw Exception('Failed to add review');
      }
    }
  }

  bool hasReview = false;
  // Método para verificar si el usuario ya ha dejado una reseña
  void checkIfUserHasReviewed(String userId) {
    if (bookReviews.isEmpty) {
      hasReview = false;
    } else {
      final review = bookReviews.any((review) => review.userId == userId);
      hasReview = review;
    }
  }

  Future<void> deleteReview(String reviewId, String bookId) async {
    try {
      // Llamar al método para eliminar la reseña y obtener la respuesta
      String result = await _firebaseService.deleteReview(reviewId);

      // Manejar la respuesta del resultado
      if (result == 'Review deleted successfully') {
        hasReview = false;
        await fetchBookReviews(bookId);
      }
    } catch (e) {
      // Manejar cualquier error que ocurra
      print('Error occurred: $e');
    }
  }
}
