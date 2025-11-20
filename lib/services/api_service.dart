// lib/services/api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/constants.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final Dio _dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ApiService._internal() : _dio = Dio(BaseOptions(
    baseUrl: Constants.apiBase,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    responseType: ResponseType.json,
  )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Attach auth token if present
        final token = await _secureStorage.read(key: 'auth_token');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (err, handler) async {
        // Example: handle 401 and try refresh (placeholder)
        if (err.response?.statusCode == 401) {
          // TODO: implement refresh token flow
          // final didRefresh = await _tryRefreshToken();
          // if (didRefresh) retry original request
        }
        return handler.next(err);
      },
    ));
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(request: true, responseBody: true, requestBody: true));
    }
  }

  // Basic request helpers
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final res = await _dio.get(path, queryParameters: queryParameters);
      return res;
    } on DioError catch (e) {
      throw ApiException(_formatError(e));
    }
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final res = await _dio.post(path, data: data, queryParameters: queryParameters);
      return res;
    } on DioError catch (e) {
      throw ApiException(_formatError(e));
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      final res = await _dio.put(path, data: data);
      return res;
    } on DioError catch (e) {
      throw ApiException(_formatError(e));
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      final res = await _dio.delete(path, data: data);
      return res;
    } on DioError catch (e) {
      throw ApiException(_formatError(e));
    }
  }

  String _formatError(DioError e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response?.data;
        if (data is Map && data['message'] != null) return data['message'].toString();
        return e.response?.statusMessage ?? e.message;
      } catch (_) {
        return e.message;
      }
    }
    return e.message;
  }

  // Convenience auth endpoints (adjust to backend)
  Future<Map<String, dynamic>> login(String phone, String password) async {
    final r = await post('/api/login', data: {'phone': phone, 'password': password});
    return Map<String, dynamic>.from(r.data);
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }
}
