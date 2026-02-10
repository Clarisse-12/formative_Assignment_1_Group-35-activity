import 'package:flutter/material.dart';
import '../utils/alu_colors.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import '../widgets/custom_text_field.dart';

// This screen allows new users to create an account. It includes fields for the student's name, email, password, and password confirmation. It also has validation to ensure that the input is correct before attempting to sign up.

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
// _SignUpScreenState: Manages the state of the sign-up form, including text controllers for each input field, loading state, and password visibility toggles. It handles the sign-up logic by calling the AuthService and provides feedback to the user based on the success or failure of the sign-up attempt. The UI is built using a combination of standard Flutter widgets and a custom `CustomTextField` for consistent styling.
class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;
// dispose: Clean up the text controllers when the widget is disposed to prevent memory leaks.
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }
// _handleSignUp: Validates the form, shows a loading indicator, and calls the AuthService to attempt sign-up. It handles success by showing a success message and navigating to the LoginScreen, and failure by showing an error message.
  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await _authService.signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    setState(() => _isLoading = false);
// Check if the widget is still mounted before trying to navigate or show a snackbar, to avoid errors if the user has navigated away.
    if (!mounted) return;
// If sign-up is successful, show a success message and navigate to the LoginScreen. If it fails, show an error message using a SnackBar.
    if (result['success']) {
      // Navigate to Login Screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully! Please login.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
      );
    }
  }
// _navigateToLogin: Navigates the user back to the Login screen when they tap the "Already have an account? Login" link. It uses `pushReplacement` to prevent the user from going back to the Sign Up screen with the back button, which is a common pattern for authentication flows.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ALUColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Logo Circle
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
                  'Student Sign-Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                // Student Name Field
                CustomTextField(
                  controller: _nameController,
                  label: 'Student Name',
                  hint: 'Enter your full name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
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
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Repeat Password Field
                CustomTextField(
                  controller: _repeatPasswordController,
                  label: 'Repeat Password',
                  hint: 'Confirm your password',
                  icon: Icons.lock,
                  isPassword: true,
                  obscureText: _obscureRepeatPassword,
                  onToggleVisibility: () {
                    setState(
                      () => _obscureRepeatPassword = !_obscureRepeatPassword,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
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
                            'Sign Up',
                            style: TextStyle(
                              color: ALUColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Navigate to Login Screen
}
