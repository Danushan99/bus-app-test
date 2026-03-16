// lib/services/auth/auth_service.dart

import 'dart:convert';
import 'package:test_bus_app/config/app_config.dart';
import 'package:test_bus_app/config/app_logger.dart';
import 'package:test_bus_app/models/user/user_model.dart';
import 'package:test_bus_app/services/storage/storage_service.dart';

class AuthService {
  final StorageService _storage;
  final AppLogger _logger;

  AuthService(this._storage, this._logger);

  Future<void> saveToken(String token) async {
    await _storage.setString(AppConfig.tokenKey, token);
    _logger.debug('Token saved.');
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.setString(AppConfig.refreshTokenKey, token);
  }

  String? getToken() => _storage.getString(AppConfig.tokenKey);

  bool get isLoggedIn {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> saveUser(UserModel user) async {
    final json = jsonEncode(user.toJson());
    await _storage.setString(AppConfig.userKey, json);
    _logger.debug('User saved: ${user.name}');
  }

  UserModel? getUser() {
    final json = _storage.getString(AppConfig.userKey);
    if (json == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(json));
    } catch (_) {
      return null;
    }
  }

  Future<void> clearSession() async {
    await _storage.remove(AppConfig.tokenKey);
    await _storage.remove(AppConfig.refreshTokenKey);
    await _storage.remove(AppConfig.userKey);
    _logger.info('Session cleared.');
  }
}
