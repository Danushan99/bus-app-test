// lib/network/interceptors/auth_interceptor.dart

import 'package:http/http.dart' as http;
import 'package:test_bus_app/config/app_config.dart';
import 'package:test_bus_app/services/storage/storage_service.dart';

class AuthInterceptor {
  final StorageService _storageService;

  AuthInterceptor(this._storageService);

  Future<Map<String, String>> appendAuthHeaders(
      Map<String, String>? headers) async {
    final Map<String, String> finalHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    final token = _storageService.getString(AppConfig.tokenKey);
    if (token != null && token.isNotEmpty) {
      finalHeaders['Authorization'] = 'Bearer $token';
    }

    return finalHeaders;
  }

  Future<void> handleUnauthenticated(http.Response response) async {
    if (response.statusCode == 401) {
      // Token expired — attempt refresh or logout
      await _storageService.remove(AppConfig.tokenKey);
    }
  }
}
