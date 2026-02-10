import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _keyLoggedIn = 'is_logged_in';
  static const _keyEmail = 'user_email';

  AuthService();

  /// Returns true if a user is already logged in (persisted).
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  /// Mock login - accepts any non-empty credentials and persists login state.
  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (email.isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyLoggedIn, true);
      await prefs.setString(_keyEmail, email);
      return {'success': true};
    }
    return {'success': false, 'message': 'Please provide valid credentials.'};
  }

  /// Mock sign-up - always succeeds if fields are non-empty (does not auto-login).
  Future<Map<String, dynamic>> signUp({required String name, required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // In a real app we'd create the user on the backend. For now just return success.
      return {'success': true};
    }
    return {'success': false, 'message': 'Please provide valid details.'};
  }

  /// Logout and clear persisted state.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLoggedIn);
    await prefs.remove(_keyEmail);
  }
}
