// lib/network/network_api_service.dart

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_bus_app/config/app_config.dart';
import 'package:test_bus_app/network/interceptors/auth_interceptor.dart';
import 'package:test_bus_app/network/interceptors/error_interceptor.dart';
import 'package:test_bus_app/config/app_logger.dart';
import 'package:test_bus_app/di/locator.dart';

class NetworkApiService {
  final http.Client _client = http.Client();

  // These dependencies are resolved via GetIt (locator)
  AuthInterceptor get _authInterceptor => getIt<AuthInterceptor>();
  ErrorInterceptor get _errorInterceptor => getIt<ErrorInterceptor>();
  AppLogger get _logger => getIt<AppLogger>();

  Duration get _timeout => Duration(milliseconds: AppConfig.connectTimeout);

  Future<dynamic> get(String url,
      {Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {
    try {
      final authHeaders = await _authInterceptor.appendAuthHeaders(headers);

      Uri uri = Uri.parse(url);
      if (queryParams != null && queryParams.isNotEmpty) {
        // Convert all query params to strings
        final stringParams =
            queryParams.map((k, v) => MapEntry(k, v.toString()));
        uri = uri.replace(queryParameters: stringParams);
      }

      if (AppConfig.isDebug) _logger.debug('GET $uri');

      final response =
          await _client.get(uri, headers: authHeaders).timeout(_timeout);

      if (AppConfig.isDebug) {
        _logger
            .debug('GET Response: ${response.statusCode} - ${response.body}');
      }

      await _authInterceptor.handleUnauthenticated(response);
      return _errorInterceptor.handleResponse(response);
    } catch (e) {
      _errorInterceptor.handleError(e);
    }
  }

  Future<dynamic> post(String url,
      {dynamic data, Map<String, String>? headers}) async {
    try {
      final authHeaders = await _authInterceptor.appendAuthHeaders(headers);
      final uri = Uri.parse(url);

      final body = data != null ? jsonEncode(data) : null;
      if (AppConfig.isDebug) _logger.debug('POST $uri Data: $body');

      final response = await _client
          .post(uri, headers: authHeaders, body: body)
          .timeout(_timeout);

      if (AppConfig.isDebug) {
        _logger
            .debug('POST Response: ${response.statusCode} - ${response.body}');
      }

      await _authInterceptor.handleUnauthenticated(response);
      return _errorInterceptor.handleResponse(response);
    } catch (e) {
      _errorInterceptor.handleError(e);
    }
  }

  Future<dynamic> put(String url,
      {dynamic data, Map<String, String>? headers}) async {
    try {
      final authHeaders = await _authInterceptor.appendAuthHeaders(headers);
      final uri = Uri.parse(url);

      final body = data != null ? jsonEncode(data) : null;
      if (AppConfig.isDebug) _logger.debug('PUT $uri Data: $body');

      final response = await _client
          .put(uri, headers: authHeaders, body: body)
          .timeout(_timeout);

      await _authInterceptor.handleUnauthenticated(response);
      return _errorInterceptor.handleResponse(response);
    } catch (e) {
      _errorInterceptor.handleError(e);
    }
  }

  Future<dynamic> patch(String url,
      {dynamic data, Map<String, String>? headers}) async {
    try {
      final authHeaders = await _authInterceptor.appendAuthHeaders(headers);
      final uri = Uri.parse(url);

      final body = data != null ? jsonEncode(data) : null;
      if (AppConfig.isDebug) _logger.debug('PATCH $uri Data: $body');

      final response = await _client
          .patch(uri, headers: authHeaders, body: body)
          .timeout(_timeout);

      await _authInterceptor.handleUnauthenticated(response);
      return _errorInterceptor.handleResponse(response);
    } catch (e) {
      _errorInterceptor.handleError(e);
    }
  }

  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    try {
      final authHeaders = await _authInterceptor.appendAuthHeaders(headers);
      final uri = Uri.parse(url);

      if (AppConfig.isDebug) _logger.debug('DELETE $uri');

      final response =
          await _client.delete(uri, headers: authHeaders).timeout(_timeout);

      await _authInterceptor.handleUnauthenticated(response);
      return _errorInterceptor.handleResponse(response);
    } catch (e) {
      _errorInterceptor.handleError(e);
    }
  }
}
