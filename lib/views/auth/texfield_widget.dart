import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.label,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
          color: const Color.fromARGB(255, 31, 30, 30)), // Color del texto
      decoration: InputDecoration(
        prefixIcon: Icon(icon,
            color: const Color.fromARGB(
                255, 31, 30, 30)), // Icono dentro del campo
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey), // Color de la etiqueta
        filled: true,
        fillColor: const Color(0xFFF0F0F0), // Gris claro para el fondo
        border: InputBorder.none, // Sin bordes
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}
