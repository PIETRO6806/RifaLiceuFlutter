import 'package:flutter/material.dart';
import 'package:rifa_liceu_flutter/pages/home.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Simulate successful registration, you can replace this with actual registration logic
                // Once registered, navigate to the home page
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Register'),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Navigate back to the login page
                Navigator.pop(context);
              },
              child: Text(
                'Already have an account? Login here',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}