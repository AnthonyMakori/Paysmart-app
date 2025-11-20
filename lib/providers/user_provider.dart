// lib/providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_service.dart';

class UserProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _token;
  Map<String, dynamic>? _user;

  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  Future<void> loadFromStorage() async {
    _token = await _storage.read(key: 'auth_token');
    // Optionally load user profile
    if (isAuthenticated) {
      try {
        final res = await ApiService().get('/api/profile');
        _user = Map<String, dynamic>.from(res.data ?? {});
      } catch (_) {
        _user = null;
      }
    }
    notifyListeners();
  }

  Future<void> login(String phone, String password) async {
    final resp = await ApiService().login(phone, password);
    // expect { token: '...', user: {...} }
    final token = resp['token'] ?? resp['access_token'];
    if (token != null) {
      _token = token as String;
      await ApiService().saveToken(_token!);
      _user = resp['user'] != null ? Map<String, dynamic>.from(resp['user']) : null;
      notifyListeners();
    } else {
      throw Exception('Missing token in login response');
    }
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    await ApiService().clearToken();
    notifyListeners();
  }
}
