import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rifa_liceu_flutter/api/api_service.dart';
import 'package:rifa_liceu_flutter/models/user_model.dart';
import 'package:rifa_liceu_flutter/utils/user_preferences.dart'; // Import your UserPreferences

class LoginController extends GetxController {
  // Observable variable to store the registered username
  RxString registeredUsername = RxString('');

  Future<void> login(
      TextEditingController emailController, TextEditingController passwordController) async {
    try {
      final String email = emailController.text;
      final String password = passwordController.text;

      // Validate email and password (you can add more validation logic)
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Please enter email and password');
        return;
      }

      // Call API service to authenticate user
      final User? user = await ApiService.loginUser(email, password);

      if (user != null) {
        // Save user information to UserPreferences
        await UserPreferences.saveUserInfo(
          userId: user.id,
          userName: user.nome,
          userEmail: user.email,
          userToken: user.senha, // You might want to use a proper field for the token
          userRifas: user.qtasRifas,
        );

        // Set the registered username
        registeredUsername.value = user.nome;

        // Navigate to home page on successful login
        Get.offAllNamed('/home');
      } else {
        // Show alert on unsuccessful login
        Get.defaultDialog(
          title: 'Login Failed',
          middleText: 'Invalid email or password. Please try again.',
          textConfirm: 'OK',
          onConfirm: () {
            // Close the alert
            Get.back();
          },
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'An unexpected error occurred');
    }
  }
}
