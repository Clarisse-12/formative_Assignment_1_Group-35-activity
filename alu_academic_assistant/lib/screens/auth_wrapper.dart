import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import '../navigations/bottom-navigation.dart';

// This screen checks if the user is logged in and directs them to the appropriate screen (Dashboard or Login).

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}
// AuthWrapper: A simple stateful widget that checks the user's authentication status on startup and navigates accordingly. It shows a loading indicator while checking.
class _AuthWrapperState extends State<AuthWrapper> {
  final _auth = AuthService();
  bool _checked = false;
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    _check();
  }
// _check: Asynchronously checks if the user is logged in and updates the state to reflect the authentication status. This determines which screen to show (Dashboard or Login).
  Future<void> _check() async {
    final v = await _auth.isLoggedIn();
    if (!mounted) return;
    setState(() {
      _loggedIn = v;
      _checked = true;
    });
  }
// build: Displays a loading indicator while checking authentication status, then shows either the Dashboard (via BottonNav) if logged in or the LoginScreen if not.
  @override
  Widget build(BuildContext context) {
    if (!_checked) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return _loggedIn ? const BottonNav() : const LoginScreen();
  }
}
