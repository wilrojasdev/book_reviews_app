import 'package:book_reviews_app/services/auth_services.dart';
import 'package:book_reviews_app/services/firebase_services.dart';
import 'package:book_reviews_app/services/shared_preference_services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseService _firebaseService = FirebaseService();
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

// // Registrar usuario
  Future<void> userRegister(
      BuildContext context, String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Crear usuario en Firebase
      UserCredential userCredential = await _authService.registerUser(
        email: email,
        password: password,
      );

      // Guardar datos en Firestore
      await _firebaseService.saveUserToFirestore(
          email, name, userCredential.user!.uid);

      // Guardar datos en SharedPreferences
      await _sharedPreferenceService.saveUser(
        userCredential.user!.uid,
        email,
        name,
      );

      _isLoading = false;
      notifyListeners();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome, $name!')),
      );

      context.go('/navigation_view');
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error registering. Please try again.')),
      );
    }
  }

  // Iniciar sesión
  Future<void> userLogin(
      BuildContext context, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Iniciar sesión en Firebase
      UserCredential userCredential = await _authService.loginUser(
        email: email,
        password: password,
      );

      // Obtener el UID del usuario
      final String userId = userCredential.user!.uid;

      final userName = await _firebaseService.getUserNameById(userId);

      // Guardar datos en SharedPreferences
      await _sharedPreferenceService.saveUser(
        userId,
        email,
        userName ?? 'user',
      );

      _isLoading = false;
      notifyListeners();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome back, $userName!')),
      );
      context.go('/navigation_view');
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error logging in. Please check your credentials.')),
      );
    }
  }
}