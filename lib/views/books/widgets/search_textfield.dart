import 'dart:async';
import 'package:flutter/material.dart';
import 'package:book_reviews_app/viewmodels/books_viewmodel.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.searchController,
    required this.bookProvider,
  });

  final TextEditingController searchController;
  final BooksViewModel bookProvider;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        if (widget.bookProvider.searchType == 'title') {
          widget.bookProvider.searchBooksByTitle(query);
        } else {
          widget.bookProvider.searchBooksByAuthor(query);
        }
      } else {
        widget.bookProvider.clearSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(30),
      child: TextField(
        controller: widget.searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText:
              'Search by ${widget.bookProvider.searchType == 'title' ? 'title' : 'author'}',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        ),
      ),
    );
  }
}
