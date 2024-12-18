import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:book_reviews_app/models/book.dart';

class GoogleBooksService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<List<Book>> fetchBooksByCategory(String category,
      {int startIndex = 0, int maxResults = 40}) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl?q=subject:$category&startIndex=$startIndex&maxResults=$maxResults'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Book> books = [];
      for (var item in data['items']) {
        var volumeInfo = item['volumeInfo'];
        Book book = Book.fromJson(volumeInfo);
        books.add(book);
      }
      return books;
    } else {
      throw Exception('Failed to load books for category: $category');
    }
  }

  Future<List<Book>> fetchBooksByTitle(String title,
      {int startIndex = 0, int maxResults = 30}) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl?q=intitle:$title&startIndex=$startIndex&maxResults=$maxResults'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Book> books = [];
      for (var item in data['items']) {
        var volumeInfo = item['volumeInfo'];
        Book book = Book.fromJson(volumeInfo);
        books.add(book);
      }
      return books;
    } else {
      throw Exception('Failed to load books by title: $title');
    }
  }

  Future<List<Book>> fetchBooksByAuthor(String author,
      {int startIndex = 0, int maxResults = 30}) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl?q=inauthor:$author&startIndex=$startIndex&maxResults=$maxResults'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Book> books = [];
      for (var item in data['items']) {
        var volumeInfo = item['volumeInfo'];
        Book book = Book.fromJson(volumeInfo);
        books.add(book);
      }
      return books;
    } else {
      throw Exception('Failed to load books by author: $author');
    }
  }
}
