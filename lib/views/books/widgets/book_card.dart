import 'package:book_reviews_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
  });
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: InkWell(
        onTap: () => context.push('/book_detail', extra: book.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            book.coverImageUrl != null
                ? Image.network(
                    book.coverImageUrl!,
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.book, size: 150),
            const SizedBox(height: 8),
            SizedBox(
              width: 160,
              child: Text(
                book.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 160,
              child: Text(
                book.authors.isNotEmpty
                    ? book.authors.join(', ')
                    : 'Unknown Author',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 160,
              child: Text(
                book.description ?? 'No description available',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
