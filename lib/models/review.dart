import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String userId;
  final String bookId;
  final double rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  // Conversión de datos desde Firestore
  factory Review.fromMap(String id, Map<String, dynamic> map) {
    return Review(
      id: id,
      userId: map['idUser'],
      bookId: map['idBook'],
      rating: map['rating'] + 0.0,
      comment: map['comment'],
      createdAt: (map['createAt'] as Timestamp).toDate(),
    );
  }

  // Conversión de datos a Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUser': userId,
      'idBook': bookId,
      'rating': rating,
      'comment': comment,
      'createAt': createdAt,
    };
  }
}
