import 'package:book_reviews_app/services/shared_preference_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferenceService _sharedPreferences = SharedPreferenceService();

  Future<UserCredential> registerUser(
      {required String email, required String password}) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> updateUserName(String name) async {
    await _auth.currentUser?.updateDisplayName(name);
  }

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
    await _sharedPreferences.removeUser();
  }
}
