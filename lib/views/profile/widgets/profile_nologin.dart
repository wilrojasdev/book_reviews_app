import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileNologin extends StatelessWidget {
  const ProfileNologin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You must log in to view your profile.',
              style: TextStyle(fontSize: 18, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                context.push('/login');
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
