import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  // Guardar los datos del usuario
  Future<void> saveUser(
      String userId, String userEmail, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId); // Guardamos el userId como String
    await prefs.setString('userEmail', userEmail); // Guardamos el email
    await prefs.setString('userName', userName); // Guardamos el nombre
  }

  // Obtener el ID del usuario guardado
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId'); // Retorna el userId guardado
  }

  // Obtener el email del usuario guardado
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail'); // Retorna el userEmail guardado
  }

  // Obtener el nombre del usuario guardado
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName'); // Retorna el userName guardado
  }

  // Eliminar el usuario guardado (cuando cierre sesión)
  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userEmail');
    await prefs.remove('userName');
  }
}
