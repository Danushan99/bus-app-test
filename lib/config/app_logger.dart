// lib/config/app_logger.dart

import 'package:flutter/foundation.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  void info(String message) {
    if (kDebugMode) print('ℹ️  [INFO] $message');
  }

  void warning(String message) {
    if (kDebugMode) print('⚠️  [WARN] $message');
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('❌ [ERROR] $message');
      if (error != null) print('   Error: $error');
      if (stackTrace != null) print('   Stack: $stackTrace');
    }
  }

  void debug(String message) {
    if (kDebugMode) print('🐛 [DEBUG] $message');
  }
}
