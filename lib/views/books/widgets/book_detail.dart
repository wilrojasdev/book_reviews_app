import 'package:book_reviews_app/models/book.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  final Book book;
  const BookDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          book.authors.isNotEmpty
              ? 'By: ${book.authors.join(', ')}'
              : 'Unknown Author',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          book.description ?? 'No description available',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
