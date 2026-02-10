import 'package:flutter/material.dart';
import './screens/auth_wrapper.dart';
import './screens/login_screen.dart';
import './navigations/bottom-navigation.dart';
import './screens/assignment-screen.dart';
import './screens/schedule-screen.dart';

void main() {
  runApp(const MyApp());
}
// MyApp: The root widget of the application. It sets up the MaterialApp with a title, theme, and the home screen as AuthWrapper, which will determine whether to show the Dashboard or Login screen based on the user's authentication status. The theme is customized to use ALU's colors for a consistent look and feel throughout the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// build: Builds the MaterialApp with a custom theme that includes ALU's primary color and sets the scaffold background color to white. The AppBar theme is also customized to match the primary color and ensure that text and icons are visible against it. The home screen is set to AuthWrapper, which will handle the logic for determining whether to show the Dashboard or Login screen based on the user's authentication status.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALU Academic Assistant',
      theme: ThemeData(
        primaryColor: const Color(0xFF003366), // ALU blue
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF003366),
          foregroundColor: Colors.white,
        ),
      ),
      home: const AuthWrapper(),
    ); 
  }
}