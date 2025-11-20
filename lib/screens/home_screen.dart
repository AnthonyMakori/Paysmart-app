// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          if (userProv.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await userProv.logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            )
        ],
      ),
      body: Center(
        child: Text(userProv.user != null ? 'Hello ${userProv.user!['name']}' : 'Welcome to PaySmart'),
      ),
    );
  }
}
