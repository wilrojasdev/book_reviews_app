import 'package:book_reviews_app/services/shared_preference_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferenceService _sharedPreferences = SharedPreferenceService();

  // Registrar un usuario con Firebase
  Future<UserCredential> registerUser(
      {required String email, required String password}) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Actualizar el nombre del usuario
  Future<void> updateUserName(String name) async {
    await _auth.currentUser?.updateDisplayName(name);
  }

  // Iniciar sesión con Firebase
  Future<UserCredential> loginUser(
      {required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Cerrar sesión
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
    await _sharedPreferences
        .removeUser(); // Eliminar el userId de SharedPreferences
  }

  // Método para obtener el usuario actual desde Firebase
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Método para verificar si un usuario está autenticado
  bool isAuthenticated() {
    return _auth.currentUser != null;
  }

  // Método para obtener el userId guardado en SharedPreferences
  Future<String?> getUserIdFromSharedPreferences() async {
    return await _sharedPreferences.getUserId();
  }
}
