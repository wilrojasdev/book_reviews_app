class User {
  final String id; // UID proporcionado por Firebase Authentication
  final String name; // Nombre del usuario
  final String email; // Correo electrónico del usuario
  final String?
      profilePicture; // URL de la imagen de perfil del usuario (opcional)

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
  });

  // Conversión de datos desde Firestore
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profilePicture: map['profilePicture'],
    );
  }

  // Conversión de datos a Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
    };
  }
}
