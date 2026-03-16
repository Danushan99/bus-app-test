// lib/config/app_config.dart
// Matches the HRM app's environment-based AppConfig pattern.

enum Environment { dev, staging, prod }

class AppConfig {
  final Environment _environment;
  final String _baseUrl;
  final String _appName;

  const AppConfig({
    required Environment environment,
    required String baseUrl,
    String appName = 'Test Bus App',
  })  : _environment = environment,
        _baseUrl = baseUrl,
        _appName = appName;

  static late AppConfig _instance;
  static AppConfig get instance => _instance;

  static void initialize(AppConfig config) {
    _instance = config;
  }

  static Environment get environment => _instance._environment;
  static String get baseUrl => _instance._baseUrl;
  static String get appName => _instance._appName;

  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'current_user';

  static int get connectTimeout => 30000;
  static int get receiveTimeout => 30000;

  static bool get isDebug => _instance._environment == Environment.dev;
}
