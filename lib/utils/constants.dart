// lib/utils/constants.dart
class Constants {
  static const String appName = 'PaySmart';
  // replace with real endpoints per environment
  static const String apiBase = String.fromEnvironment('API_BASE', defaultValue: 'https://your-backend.example.com');
  static const String appVersion = '0.1.0';
}
