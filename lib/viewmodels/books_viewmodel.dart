import 'package:book_reviews_app/models/book.dart';
import 'package:book_reviews_app/services/firebase_services.dart';
import 'package:book_reviews_app/services/google_books_api.dart';
import 'package:flutter/foundation.dart';

class BooksViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  final GoogleBooksService _googleBooksService = GoogleBooksService();

  List<String> categories = [];
  List<Book> allBooks = [];
  bool isLoading = false;
  List<Book> filteredBooks = [];
  List<Book> categoryBooks = [];
  String searchType = 'title';

  Future<void> loadCategories() async {
    try {
      categories = await _firebaseService.getCategories();
      notifyListeners();
      await _loadBooksForCategories();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading categories: $e');
      }
    }
  }

  Future<void> _loadBooksForCategories() async {
    for (var category in categories) {
      try {
        List<Book> books =
            await _googleBooksService.fetchBooksByCategory(category);
        allBooks.addAll(books);
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print('Error loading books for category $category: $e');
        }
      }
    }
  }

  Future<void> loadBooksForCategory(
      String category, int pageKey, int pageSize) async {
    try {
      List<Book> books = await _googleBooksService.fetchBooksByCategory(
        category,
        maxResults: pageSize,
        startIndex: pageKey,
      );
      isLoading = false;
      categoryBooks.addAll(books);
      allBooks.addAll(books);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading books for category $category: $e');
      }
      isLoading = false;
      notifyListeners();
    }
  }

  List<Book> getBooksByCategoryPreview(String category) {
    return allBooks
        .where((book) => book.subjects!.contains(category))
        .take(10)
        .toList();
  }

  List<Book> getBooksByCategory(String category) {
    return allBooks.where((book) => book.subjects!.contains(category)).toList();
  }

  Book getBookById(String id) {
    return allBooks.firstWhere((book) => book.id == id);
  }

  void filterBooks(String query) {
    if (searchType == 'title') {
      filteredBooks = allBooks
          .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (searchType == 'author') {
      filteredBooks = allBooks
          .where((book) => book.authors.any(
              (author) => author.toLowerCase().contains(query.toLowerCase())))
          .toList();
    }
    notifyListeners();
  }

  void changeSearchType(String type) {
    searchType = type;
    notifyListeners();
  }

  List<Book> searchBooks = [];

  Future<void> searchBooksByTitle(String title) async {
    isLoading = true;
    notifyListeners();
    try {
      final searchBooksbyTitle =
          await _googleBooksService.fetchBooksByTitle(title);
      searchBooks = searchBooksbyTitle;
      allBooks.addAll(searchBooksbyTitle);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error searching books by title: $e");
      }
      searchBooks = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchBooksByAuthor(String author) async {
    isLoading = true;
    notifyListeners();
    try {
      final searchBooksbyAuthor =
          await _googleBooksService.fetchBooksByAuthor(author);
      searchBooks = searchBooksbyAuthor;
      allBooks.addAll(searchBooksbyAuthor);
    } catch (e) {
      if (kDebugMode) {
        print("Error searching books by author: $e");
      }
      searchBooks = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    searchBooks = [];
    notifyListeners();
  }
}
