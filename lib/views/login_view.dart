import 'dart:async';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Center content vertically
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content horizontally
          children: [
            Image.asset(
                'assets/images/company_logo.png'), // Replace with your logo path
            const SizedBox(height: 20), // Add spacing between widgets
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10), // Add spacing between widgets
            const TextField(
              obscureText: true, // Hide password input
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20), // Add spacing between widgets
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
