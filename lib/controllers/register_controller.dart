import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rifa_liceu_flutter/api/api_service.dart';
import 'package:rifa_liceu_flutter/models/user_model.dart';
import 'package:rifa_liceu_flutter/utils/user_preferences.dart'; // Import your UserPreferences

class RegisterController extends GetxController {
  // Observable variable to store the registered username
  RxString registeredUsername = RxString('');

  Future<void> register(
      TextEditingController usernameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      ) async {
    try {
      String username = usernameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      // Validate the input fields (you can add more validation logic)
      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'All fields are required');
        return;
      }

      // Perform registration logic using your API service
      bool success = await ApiService.registerUser(username, email, password);

      if (success) {
        // Set the registered username
        registeredUsername.value = username;

        // Login after successful registration
        User? user = await loginAfterRegistration(email, password);

        if (user != null) {
          // Save user information to UserPreferences
          await UserPreferences.saveUserInfo(
            userId: user.id,
            userName: user.nome,
            userEmail: user.email,
            userToken: user.senha, // You might want to use a proper field for the token
            userRifas: user.qtasRifas,
          );

          // Navigate to home page
          Get.offAllNamed('/home');
        } else {
          // Handle the case where login after registration fails
          Get.snackbar('Error', 'Login after registration failed. Please try logging in manually.');
        }
      } else {
        Get.snackbar('Error', 'Registration failed. User already exists or other error.');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An unexpected error occurred');
    }
  }

  Future<User?> loginAfterRegistration(String email, String password) async {
    try {
      // Perform login using your API service
      User? user = await ApiService.loginUser(email, password);

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
