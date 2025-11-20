import 'package:flutter/material.dart';
import '../../widgets/input_field.dart';
import '../../widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool loading = false;

  void _register() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => loading = false);
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              InputField(controller: _nameController, hintText: 'Full name'),
              const SizedBox(height: 12),
              InputField(controller: _phoneController, hintText: 'Phone number'),
              const SizedBox(height: 20),
              CustomButton(text: loading ? 'Creating...' : 'Create Account', onPressed: loading ? null : _register),
            ],
          ),
        ),
      ),
    );
  }
}