import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rifa_liceu_flutter/models/user_model.dart';

class ApiService {
  static final String baseUrl = 'https://rifa-liceu.glitch.me';

  static Future<bool> registerUser(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nome': username, 'email': email, 'senha': password, 'qtasRifas' : 0}),
      );

      if (response.statusCode == 200) {
        return true; // Registration successful
      } else if (response.statusCode == 400) {
        // User already exists
        return false;
      } else {
        // Other errors
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<User?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': password}),
      );

      if (response.statusCode == 200) {
        // Parse the response body to get a User object
        final Map<String, dynamic> userData = jsonDecode(response.body);
        return User.fromJson(userData);
      } else if (response.statusCode == 400) {
        // Invalid email or password
        return null;
      } else {
        // Other errors
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
