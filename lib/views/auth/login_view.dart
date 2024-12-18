import 'package:book_reviews_app/viewmodels/auth_viewmodel.dart';
import 'package:book_reviews_app/views/auth/texfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sign in to your account',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              // Campo de correo
              CustomTextField(
                controller: _emailController,
                icon: Icons.email,
                label: 'Email',
              ),
              const SizedBox(height: 16),
              // Campo de contraseña
              CustomTextField(
                controller: _passwordController,
                icon: Icons.lock,
                label: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 32),
              // Botón de inicio de sesión
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, child) {
                  return authViewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () => authViewModel.userLogin(context,
                              _emailController.text, _passwordController.text),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff55b047),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        );
                },
              ),
              const SizedBox(height: 16),
              // Botón de ir a la pantalla de registro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      context.push('/register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
