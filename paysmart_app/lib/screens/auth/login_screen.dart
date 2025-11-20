import 'package:flutter/material.dart';
import '../../widgets/input_field.dart';
import '../../widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;

  void _login() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => loading = false);
    // For now, navigate to home directly (will connect to backend later)
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Login to continue to PaySmart'),
              const SizedBox(height: 24),
              InputField(controller: _phoneController, hintText: 'Phone number'),
              const SizedBox(height: 12),
              InputField(controller: _passwordController, hintText: 'Password', obscureText: true),
              const SizedBox(height: 20),
              CustomButton(
                text: loading ? 'Logging in...' : 'Login',
                onPressed: loading ? null : _login,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                    child: const Text('Register'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}