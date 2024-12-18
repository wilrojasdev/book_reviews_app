import 'package:book_reviews_app/models/book.dart';
import 'package:book_reviews_app/models/review.dart';
import 'package:book_reviews_app/services/firebase_services.dart';
import 'package:book_reviews_app/services/google_books_api.dart';
import 'package:flutter/material.dart';

class BooksViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  final GoogleBooksService _googleBooksService = GoogleBooksService();

  List<String> categories = [];
  List<Book> allBooks = []; // Lista para almacenar todos los libros
  bool isLoading = false;
  List<Book> filteredBooks = [];
  List<Book> categoryBooks = [];
  String searchType = 'title'; // 'title' o 'author'

  // Obtener categorías desde Firebase
  Future<void> loadCategories() async {
    try {
      categories = await _firebaseService.getCategories();
      notifyListeners(); // Notifica a la vista para que actualice el UI

      // Cargar los libros de todas las categorías
      await _loadBooksForCategories();
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  // Cargar libros de todas las categorías
  Future<void> _loadBooksForCategories() async {
    for (var category in categories) {
      try {
        // Cargar los libros para la categoría actual
        List<Book> books =
            await _googleBooksService.fetchBooksByCategory(category);

        // Agregar los libros a la lista
        allBooks.addAll(books);

        // Notificar a la vista para que actualice
        notifyListeners();
      } catch (e) {
        print('Error loading books for category $category: $e');
      }
    }
  }

  Future<void> loadBooksForCategory(
      String category, int pageKey, int pageSize) async {
    try {
      // Llamamos a la API para obtener los libros para la categoría actual con paginación
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
      print('Error loading books for category $category: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  // Obtener libros por categoría (realizando un filtro en la lista)
  List<Book> getBooksByCategoryPreview(String category) {
    return allBooks
        .where((book) => book.subjects!.contains(category))
        .take(10)
        .toList(); // Filtra por categoría
  }

  // Obtener libros por categoría (realizando un filtro en la lista)
  List<Book> getBooksByCategory(String category) {
    return allBooks
        .where((book) => book.subjects!.contains(category))
        .toList(); // Filtra por categoría
  }

  // Obtener libros por categoría (realizando un filtro en la lista)
  Book getBookById(String id) {
    return allBooks.firstWhere((book) => book.id == id); // Filtra por categoría
  }

  // Filtrar los libros según el texto de búsqueda
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

  // Cambiar el tipo de búsqueda
  void changeSearchType(String type) {
    searchType = type;
    notifyListeners();
  }

  List<Book> searchBooks =
      []; // Lista para almacenar los resultados de búsqueda

  // Método para buscar libros por título
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
      print("Error searching books by title: $e");
      searchBooks = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Método para buscar libros por autor
  Future<void> searchBooksByAuthor(String author) async {
    isLoading = true;
    notifyListeners();
    try {
      final searchBooksbyTitle =
          await _googleBooksService.fetchBooksByAuthor(author);
      searchBooks = searchBooksbyTitle;
      allBooks.addAll(searchBooksbyTitle);
    } catch (e) {
      print("Error searching books by author: $e");
      searchBooks = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Método para limpiar los resultados de la búsqueda
  void clearSearch() {
    searchBooks = [];
    notifyListeners();
  }
}
