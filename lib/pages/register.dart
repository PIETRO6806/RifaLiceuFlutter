// register.dart

import 'package:flutter/material.dart';
import 'package:rifa_liceu_flutter/pages/home.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/pascoaliceu.png', // Replace with the actual image path
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 16),
                Text(
                  'Register',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Simulate successful registration, you can replace this with actual registration logic
                    // Access the entered username, email, and password using the controllers
                    String username = usernameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;

                    // You can perform registration logic here
                    // For simplicity, let's just print the values for now
                    print('Username: $username, Email: $email, Password: $password');

                    // Once registered, navigate to the home page
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Register'),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    // Close the register page and navigate back to the login page
                    Navigator.popUntil(context, ModalRoute.withName('/login'));
                  },
                  child: Text(
                    'Already have an account? Login here',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}