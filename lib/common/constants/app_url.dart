// lib/common/constants/app_url.dart

import 'package:test_bus_app/config/app_config.dart';

class AppUrl {
  static String get baseUrl => AppConfig.baseUrl;

  // Auth
  static String get loginApi => '$baseUrl/api/auth/login';
  static String get logoutApi => '$baseUrl/api/auth/logout';
  static String get refreshTokenApi => '$baseUrl/api/auth/refresh-token';
  static String get registerApi => '$baseUrl/api/auth/register';

  // User
  static String get currentUserApi => '$baseUrl/api/user/me';
  static String get updateProfileApi => '$baseUrl/api/user/profile';
  static String get changePasswordApi => '$baseUrl/api/user/change-password';
}
