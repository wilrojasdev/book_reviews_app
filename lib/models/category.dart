class Category {
  final String name;
  final String key;

  Category({required this.name, required this.key});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
      key: json['key'] ?? '',
    );
  }
}
