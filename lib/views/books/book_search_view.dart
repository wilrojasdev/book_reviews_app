import 'package:book_reviews_app/views/books/widgets/nobooks_found_widget.dart';
import 'package:book_reviews_app/views/books/widgets/search_chip.dart';
import 'package:book_reviews_app/views/books/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:book_reviews_app/viewmodels/books_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class BookSearchView extends StatefulWidget {
  const BookSearchView({super.key});

  @override
  State<BookSearchView> createState() => _BookSearchViewState();
}

class _BookSearchViewState extends State<BookSearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BooksViewModel>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchChip(
                bookProvider: bookProvider,
                searchController: _searchController),
            SearchTextField(
                searchController: _searchController,
                bookProvider: bookProvider),
            Expanded(
              child: Consumer<BooksViewModel>(
                  builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.searchBooks.isEmpty) {
                  return const NoBooksFoundWidget();
                }

                return ListView.builder(
                  itemCount: viewModel.searchBooks.length,
                  itemBuilder: (context, index) {
                    final book = viewModel.searchBooks[index];
                    return ListTile(
                      leading: book.coverImageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                book.coverImageUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.book,
                              size: 50, color: Colors.grey),
                      title: Text(book.title),
                      subtitle: Text(
                        book.authors.isNotEmpty
                            ? 'By: ${book.authors.join(', ')}'
                            : 'Unknown Author',
                      ),
                      onTap: () {
                        context.push('/book_detail', extra: book.id);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
