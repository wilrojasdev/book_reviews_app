class Book {
  final String title;
  final List<String> authors;
  final List<String>? subjects;
  final String? description;
  final String? coverImageUrl;
  final String id;

  Book({
    required this.title,
    required this.authors,
    this.subjects,
    this.description,
    this.coverImageUrl,
    required this.id,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'No title',
      authors:
          json['authors'] != null ? List<String>.from(json['authors']) : [],
      subjects: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
      description: json['description'] ?? 'No description available',
      coverImageUrl:
          json['imageLinks']?['large'] ?? json['imageLinks']?['thumbnail'],
      id: (json['pageCount'].toString() + json['title']),
    );
  }
}
