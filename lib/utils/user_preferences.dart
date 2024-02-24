import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _keyUserId = 'userId';
  static const String _keyUserName = 'userName';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserToken = 'userToken';
  static const String _keyUserRifas = 'userRifas';

  // Save user information
  static Future<void> saveUserInfo({
    required String userId,
    required String userName,
    required String userEmail,
    required String userToken,
    required int userRifas,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUserId, userId);
    prefs.setString(_keyUserName, userName);
    prefs.setString(_keyUserEmail, userEmail);
    prefs.setString(_keyUserToken, userToken);
    prefs.setInt(_keyUserRifas, userRifas);
  }

  // Retrieve user information
  static Future<Map<String, dynamic>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'userId': prefs.getString(_keyUserId) ?? '',
      'userName': prefs.getString(_keyUserName) ?? '',
      'userEmail': prefs.getString(_keyUserEmail) ?? '',
      'userToken': prefs.getString(_keyUserToken) ?? '',
      'userRifas': prefs.getInt(_keyUserRifas) ?? 0,
    };
  }

  // Clear user information (logout)
  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
