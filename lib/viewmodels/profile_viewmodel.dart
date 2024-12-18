import 'package:book_reviews_app/services/shared_preference_services.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  String? userId;
  String? userName;
  String? userEmail;
  bool isLoading = true;

  Future<void> loadUserData() async {
    final prefsService = SharedPreferenceService();
    final id = await prefsService.getUserId();

    if (id != null) {
      final name = await prefsService.getUserName();
      final email = await prefsService.getUserEmail();

      userId = id;
      userName = name ?? "Guest User";
      userEmail = email ?? "No email available";
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await SharedPreferenceService().removeUser();
    userId = null;
    userName = null;
    userEmail = null;
    notifyListeners();
  }
}
