class Book {
  final String title; // Título del libro
  final List<String> authors; // Lista de autores
  final List<String>?
      subjects; // Categorías o temas del libro (lista de strings)
  final String? description; // Resumen o descripción del libro
  final String? coverImageUrl; // URL de la portada (si está disponible)
  final String id; // ID único del libro

  Book({
    required this.title,
    required this.authors,
    this.subjects,
    this.description,
    this.coverImageUrl,
    required this.id,
  });

  // Conversión de datos desde la respuesta de la API de Google Books
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'No title', // Título
      authors: json['authors'] != null
          ? List<String>.from(json['authors'])
          : [], // Lista de autores
      subjects: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [], // Lista de categorías
      description:
          json['description'] ?? 'No description available', // Descripción
      coverImageUrl: json['imageLinks']?['large'] ??
          json['imageLinks']?[
              'thumbnail'], // URL de la portada (usamos el tamaño más grande disponible)
      id: (json['pageCount'].toString() + json['title']), // ID único del libro
    );
  }
}
