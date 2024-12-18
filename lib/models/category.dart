class Category {
  final String name;
  final String key;

  Category({required this.name, required this.key});

  // Método para crear un objeto Category desde un JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
      key: json['key'] ?? '',
    );
  }
}
