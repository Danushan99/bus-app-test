// lib/network/interceptors/error_interceptor.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_bus_app/config/app_logger.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;
  AppException({required this.message, this.statusCode});
  @override
  String toString() => 'AppException($statusCode): $message';
}

class ErrorInterceptor {
  final AppLogger _logger;
  ErrorInterceptor(this._logger);

  dynamic handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      }
      return null;
    } else {
      final message = _parseStatusCode(response.statusCode, response.body);
      _logger.error('Network error: $message (HTTP ${response.statusCode})');
      throw AppException(
        message: message,
        statusCode: response.statusCode,
      );
    }
  }

  void handleError(dynamic error) {
    String message = 'An unexpected error occurred.';
    if (error is http.ClientException) {
      message = 'Connection failed. Please check your internet connection.';
    } else if (error is FormatException) {
      message = 'Bad response format.';
    } else if (error is AppException) {
      throw error; // Re-throw custom exceptions
    } else {
      message = error.toString();
    }

    _logger.error('Network error: $message', error);
    throw AppException(message: message);
  }

  String _parseStatusCode(int code, String body) {
    try {
      final json = jsonDecode(body);
      if (json is Map<String, dynamic> && json['message'] != null) {
        return json['message'].toString();
      }
    } catch (_) {}

    switch (code) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Unauthorized. Please log in again.';
      case 403:
        return 'Forbidden. You don\'t have permission.';
      case 404:
        return 'Resource not found.';
      case 422:
        return 'Validation error.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Something went wrong (HTTP $code).';
    }
  }
}
