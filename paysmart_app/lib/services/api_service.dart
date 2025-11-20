import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://your-backend.example.com',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  // Example placeholder for POST /login
  Future<Response> login(String phone, String password) {
    return _dio.post('/api/login', data: {'phone': phone, 'password': password});
  }
}