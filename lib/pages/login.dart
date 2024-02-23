import 'package:flutter/material.dart';
import 'package:rifa_liceu_flutter/pages/home.dart';
import 'package:rifa_liceu_flutter/pages/register.dart'; // Import the new page

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Simulate successful login, you can replace this with actual authentication logic
                // Once logged in, navigate to the home page
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Login'),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Navigate to the register page
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                "Don't have an account yet? Register here",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}