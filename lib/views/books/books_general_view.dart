import 'package:book_reviews_app/models/book.dart';
import 'package:book_reviews_app/viewmodels/books_viewmodel.dart';
import 'package:book_reviews_app/views/books/widgets/book_card.dart';
import 'package:book_reviews_app/views/books/widgets/category_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BooksGeneralView extends StatefulWidget {
  final ScrollController scrollController;
  const BooksGeneralView({super.key, required this.scrollController});

  @override
  State<BooksGeneralView> createState() => _BooksGeneralViewState();
}

class _BooksGeneralViewState extends State<BooksGeneralView> {
  @override
  void initState() {
    super.initState();
    final bookProvider = Provider.of<BooksViewModel>(context, listen: false);
    bookProvider.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BooksViewModel>(builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            controller: widget.scrollController,
            itemCount: viewModel.categories.length,
            itemBuilder: (context, index) {
              final category = viewModel.categories[index];
              final List<Book> booksForCategory =
                  viewModel.getBooksByCategoryPreview(category);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleCategory(category: category),
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: booksForCategory.length + 1,
                        itemBuilder: (context, bookIndex) {
                          if (bookIndex == booksForCategory.length) {
                            return GestureDetector(
                              onTap: () {
                                context.push('/books_category',
                                    extra: category);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 40,
                                  color: Colors.blue,
                                ),
                              ),
                            );
                          } else {
                            final book = booksForCategory[bookIndex];
                            return BookCard(book: book);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
