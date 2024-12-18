import 'package:book_reviews_app/viewmodels/books_viewmodel.dart';
import 'package:flutter/material.dart';

class SearchChip extends StatelessWidget {
  const SearchChip({
    super.key,
    required this.bookProvider,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final BooksViewModel bookProvider;
  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ChoiceChip(
              label: const Text('Title'),
              selected: bookProvider.searchType == 'title',
              onSelected: (selected) {
                bookProvider.changeSearchType('title');
                _searchController.clear();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ChoiceChip(
              label: const Text('Author'),
              selected: bookProvider.searchType == 'author',
              onSelected: (selected) {
                bookProvider.changeSearchType('author');
                _searchController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
