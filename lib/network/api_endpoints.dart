// lib/network/api_endpoints.dart

class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String register = '/auth/register';

  // User
  static const String currentUser = '/user/me';
  static const String updateProfile = '/user/profile';
  static const String changePassword = '/user/change-password';
}
