import 'package:flutter/material.dart';
import '../utils/alu_colors.dart';
import '../services/auth_service.dart';
import 'signup_screen.dart';
import '../navigations/bottom-navigation.dart';
import '../widgets/custom_text_field.dart';

// LoginScreen: The main entry point for users to log in. It includes form validation, loading state, and error handling. It also provides a link to the Sign Up screen.
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
// _LoginScreenState: Manages the state of the login form, including text controllers, loading state, and password visibility. It handles the login logic and navigation to the Sign Up screen. The UI is built using a combination of standard Flutter widgets and a custom `CustomTextField` for consistent styling.
class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
// dispose: Clean up the text controllers when the widget is disposed to prevent memory leaks.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
// _handleLogin: Validates the form, shows a loading indicator, and calls the AuthService to attempt login. It handles success by navigating to the main app and failure by showing an error message.
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await _authService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
// After the login attempt, we stop showing the loading indicator regardless of success or failure.
    setState(() => _isLoading = false);
// Check if the widget is still mounted before trying to navigate or show a snackbar, to avoid errors if the user has navigated away.
    if (!mounted) return;
// If login is successful, navigate to the app home (bottom navigation / dashboard). If it fails, show an error message using a SnackBar.
    if (result['success']) {
      // Navigate to the app home (bottom navigation / dashboard)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottonNav()),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
      );
    }
  }
// _navigateToSignUp: Navigates the user to the Sign Up screen when they tap the "Sign Up" link. It uses `pushReplacement` to prevent the user from going back to the Login screen with the back button, which is a common pattern for authentication flows.
  void _navigateToSignUp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
// build: Displays the login form with email and password fields, a login button, and a link to the Sign Up screen. It uses the `CustomTextField` widget for consistent styling of the input fields. The login button shows a loading indicator when the login process is in progress.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALUColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),

                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: ALUColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.school, size: 40, color: ALUColors.primary),
                ),

                const SizedBox(height: 30),

                // Title
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Login to your account',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),

                const SizedBox(height: 50),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Password Field
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  icon: Icons.lock,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onToggleVisibility: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ALUColors.accent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: ALUColors.primary,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                              color: ALUColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 30),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: _navigateToSignUp,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: ALUColors.accent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Field implementation extracted to `CustomTextField` in `lib/widgets`.
}
