import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rifa_liceu_flutter/api/api_service.dart';

class RegisterController extends GetxController {
  // Remove the TextEditingController instances from here

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
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'Registration failed. User already exists or other error.');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An unexpected error occurred');
    }
  }
}
