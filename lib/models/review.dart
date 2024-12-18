import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String userId;
  final String userName; // Campo para el nombre del usuario
  final String bookId;
  final String comment;
  final double rating;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.userName, // Asegúrate de incluirlo en el constructor
    required this.bookId,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  // Método de fábrica para convertir los datos del Firestore a un objeto Review
  factory Review.fromMap(String id, Map<String, dynamic> data) {
    return Review(
      id: id,
      userId: data['userId'],
      userName: data['userName'], // Obtener el nombre del usuario
      bookId: data['idBook'],
      comment: data['comment'],
      rating: data['rating'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp)
              .toDate() // Si 'createdAt' no es nulo, convertirlo
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName, // Guardar el nombre del usuario
      'idBook': bookId,
      'comment': comment,
      'rating': rating,
      'createdAt': Timestamp.fromDate(
          createdAt), // Convertir DateTime a Timestamp para guardarlo
    };
  }
}
