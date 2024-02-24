import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = 'https://rifa-liceu.glitch.me';

  static Future<bool> registerUser(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'email': email, 'password': password}),
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

  static Future<bool> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': password}),
      );

      if (response.statusCode == 200) {
        // Login successful
        return true;
      } else if (response.statusCode == 400) {
        // Invalid email or password
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
}
