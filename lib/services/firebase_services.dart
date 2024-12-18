import 'package:book_reviews_app/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para obtener la colección 'categories' desde Firestore
  Future<List<String>> getCategories() async {
    try {
      // Consultar la colección 'categories' en Firestore
      QuerySnapshot snapshot = await _firestore.collection('categories').get();

      // Convertir los documentos de la colección en una lista de categorías
      List<String> categories = [];
      for (var doc in snapshot.docs) {
        // Asumiendo que cada documento tiene un campo 'name' que representa la categoría
        categories.add(doc['name']); // Ajusta esto según tu estructura de datos
      }

      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Failed to load categories');
    }
  }

// Método para obtener las reseñas de un libro específico desde Firestore
  Future<List<Review>> getReviewsByBookId(String bookId) async {
    try {
      // Consultar la colección 'reviews' filtrando por el campo 'bookId' y ordenando por 'createdAt' en orden descendente
      QuerySnapshot snapshot = await _firestore
          .collection('review')
          .where('idBook', isEqualTo: bookId)
          .get();

      // Convertir los documentos de la colección en una lista de objetos Review
      List<Review> reviews = snapshot.docs
          .map((doc) =>
              Review.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();

      return reviews;
    } catch (e) {
      print('Error fetching reviews: $e');
      throw Exception('Failed to load reviews');
    }
  }

  Future<void> addReview(Review review) async {
    try {
      // Generar un nuevo ID para la reseña usando Firestore
      DocumentReference reviewRef = _firestore.collection('review').doc();

      // Crear la reseña con el ID generado por Firestore
      Review newReview = Review(
        id: reviewRef.id,
        userId: review.userId,
        bookId: review.bookId,
        comment: review.comment,
        rating: review.rating,
        createdAt: review.createdAt,
      );

      // Agregar la reseña a la colección 'reviews' en Firestore
      await reviewRef.set(newReview.toMap());
    } catch (e) {
      throw Exception('Failed to add review');
    }
  }

  Future<void> saveUserToFirestore(
      String email, String name, String uid) async {
    try {
      // Guardar el usuario en la colección 'users' con el uid como documento
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'name': name,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving user to Firestore: $e');
      throw Exception('Failed to save user data to Firestore');
    }
  }

  Future<String?> getUserNameById(String userId) async {
    try {
      // Acceder al documento del usuario en la colección 'users' usando el userId
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(userId).get();

      // Verificar si el documento existe
      if (userDoc.exists) {
        // Retornar el valor del campo 'name', o null si no está presente
        return userDoc.data()?['name'];
      } else {
        // Retornar null si el documento no existe
        print('User with ID $userId not found.');
        return null;
      }
    } catch (e) {
      // Manejar errores durante la consulta a Firestore
      print('Error fetching user name: $e');
      throw Exception('Failed to fetch user name');
    }
  }

  Future<String> deleteReview(String reviewId) async {
    try {
      // Obtener la referencia del documento en la colección 'reviews' usando el ID de la reseña
      DocumentReference reviewRef =
          _firestore.collection('review').doc(reviewId);

      // Eliminar el documento
      await reviewRef.delete();

      // Retornar un mensaje indicando que la reseña fue eliminada con éxito
      return 'Review deleted successfully';
    } catch (e) {
      print('Error deleting review: $e');
      // Retornar un mensaje de error si ocurre una excepción
      return 'Failed to delete review';
    }
  }
}
