import 'package:book_reviews_app/models/book.dart';
import 'package:book_reviews_app/viewmodels/books_viewmodel.dart';
import 'package:book_reviews_app/views/books/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BooksCategoryView extends StatefulWidget {
  final String category;

  const BooksCategoryView({super.key, required this.category});
  @override
  State<BooksCategoryView> createState() => _BooksCategoryViewState();
}

class _BooksCategoryViewState extends State<BooksCategoryView> {
  static const _pageSize = 15;
  final PagingController<int, Book> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    final bookProvider = Provider.of<BooksViewModel>(context, listen: false);

    try {
      await bookProvider.loadBooksForCategory(
          widget.category, pageKey, _pageSize);
      final isLastPage = bookProvider.categoryBooks.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(bookProvider.categoryBooks);
      } else {
        final nextPageKey = pageKey + bookProvider.categoryBooks.length;
        _pagingController.appendPage(bookProvider.categoryBooks, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.category} Books')),
      body: PagedGridView<int, Book>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Book>(
          itemBuilder: (context, book, index) {
            return BookCard(book: book);
          },
          noItemsFoundIndicatorBuilder: (_) =>
              const Center(child: Text('No books found')),
          firstPageProgressIndicatorBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          newPageProgressIndicatorBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 0.58,
        ),
      ),
    );
  }
}
