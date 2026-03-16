// lib/repository/auth/auth_repository.dart

import 'package:dartz/dartz.dart';
import 'package:test_bus_app/config/app_logger.dart';
import 'package:test_bus_app/models/user/user_model.dart';
import 'package:test_bus_app/network/interceptors/error_interceptor.dart';
import 'package:test_bus_app/network/network_api_service.dart';
import 'package:test_bus_app/common/constants/app_url.dart';
import 'package:test_bus_app/services/auth/auth_service.dart';

class AuthRepository {
  final NetworkApiService _apiService;
  final AuthService _authService;
  final AppLogger _logger;

  AuthRepository(this._apiService, this._authService, this._logger);

  Future<Either<AppException, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Bypass the API for now, simulating a successful login
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate network delay

      final user = UserModel(
        id: '1',
        name: 'Demo User',
        email: email,
        role: 'admin',
        createdAt: DateTime.now(),
      );

      const token = 'mock_jwt_token';
      const refreshToken = 'mock_refresh_token';

      await _authService.saveToken(token);
      await _authService.saveRefreshToken(refreshToken);
      await _authService.saveUser(user);

      _logger.info('Login success (mock): ${user.email}');
      return Right(user);
    } catch (e) {
      return Left(AppException(message: 'Unexpected error: $e'));
    }
  }

  Future<Either<AppException, Unit>> logout() async {
    try {
      await _apiService.post(AppUrl.logoutApi);
      await _authService.clearSession();
      return const Right(unit);
    } catch (_) {
      // Always clear session locally even if API call fails
      await _authService.clearSession();
      return const Right(unit);
    }
  }

  bool get isLoggedIn => _authService.isLoggedIn;
  UserModel? get cachedUser => _authService.getUser();
}
