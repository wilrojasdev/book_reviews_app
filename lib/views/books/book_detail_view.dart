import 'package:book_reviews_app/models/book.dart';
import 'package:book_reviews_app/viewmodels/books_viewmodel.dart';
import 'package:book_reviews_app/viewmodels/review_viewmodel.dart';
import 'package:book_reviews_app/views/books/widgets/add_review.dart';
import 'package:book_reviews_app/views/books/widgets/book_detail.dart';
import 'package:book_reviews_app/views/books/widgets/review_section.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailView extends StatefulWidget {
  final String bookId;

  const BookDetailView({
    super.key,
    required this.bookId,
  });

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  @override
  void initState() {
    super.initState();
    final bookProvider = Provider.of<ReviewsViewModel>(context, listen: false);
    bookProvider.fetchBookReviews(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BooksViewModel>(context, listen: true);
    final reviewProvider = Provider.of<ReviewsViewModel>(context, listen: true);
    final Book book = bookProvider.getBookById(widget.bookId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.white,
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.black
                          .withOpacity(0.5), // Fondo oscuro transparente
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      book.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              background: BookImage(book: book),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: (bookProvider.isLoading || reviewProvider.isLoading)
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        BookDetails(book: book),
                        const SizedBox(height: 24),
                        ReviewSection(
                          reviewProvider: reviewProvider,
                          userName: 'nameUser',
                        ),
                        const SizedBox(height: 24),
                        AddReview(
                          bookId: book.id,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookImage extends StatelessWidget {
  final Book book;
  const BookImage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: book.coverImageUrl!,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
