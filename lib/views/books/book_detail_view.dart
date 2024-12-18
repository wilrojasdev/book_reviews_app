import 'package:book_reviews_app/models/book.dart';
import 'package:book_reviews_app/services/firebase_services.dart';
import 'package:book_reviews_app/services/shared_preference_services.dart';
import 'package:book_reviews_app/viewmodels/books_viewmodel.dart';
import 'package:book_reviews_app/viewmodels/review_viewmodel.dart';
import 'package:book_reviews_app/views/books/widgets/add_review.dart';
import 'package:book_reviews_app/views/books/widgets/book_detail.dart';
import 'package:book_reviews_app/views/books/widgets/review_section.dart';
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
  final FirebaseService _firebaseService = FirebaseService();
  @override
  void initState() {
    super.initState();
    final bookProvider = Provider.of<ReviewsViewModel>(context, listen: false);
    bookProvider.fetchBookReviews(widget.bookId);

    _checkUserLoginStatus();
  }

  String idUser = '';
  String nameUser = '';
  void _checkUserLoginStatus() async {
    final bookProvider = Provider.of<ReviewsViewModel>(context, listen: false);
    String? userId = await SharedPreferenceService().getUserId();
    final userName = await _firebaseService.getUserNameById(userId!);
    idUser = userId;
    nameUser = userName!;
    bookProvider.checkIfUserHasReviewed(idUser);
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BooksViewModel>(context);
    final reviewProvider = Provider.of<ReviewsViewModel>(context, listen: true);
    final Book book = bookProvider.getBookById(widget.bookId);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: bookProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  BookImage(book: book),
                  const SizedBox(height: 16),
                  BookDetails(book: book),
                  const SizedBox(height: 24),
                  ReviewSection(
                    reviewProvider: reviewProvider,
                    userName: nameUser,
                    currentUserId: idUser,
                  ),
                  const SizedBox(height: 24),
                  AddReview(
                    bookId: book.id,
                  ),
                ],
              ),
      ),
    );
  }
}

class BookImage extends StatelessWidget {
  final Book book;
  const BookImage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return book.coverImageUrl != null
        ? Image.network(
            book.coverImageUrl!,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          )
        : const Icon(Icons.book, size: 250);
  }
}
