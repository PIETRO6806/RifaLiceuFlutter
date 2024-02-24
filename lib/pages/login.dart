import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rifa_liceu_flutter/controllers/login_controller.dart';
import 'package:rifa_liceu_flutter/pages/register.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  'Login',
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  onPressed: () => loginController.login(emailController, passwordController),
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
        ],
      ),
    );
  }
}
