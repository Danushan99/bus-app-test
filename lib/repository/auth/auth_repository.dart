// lib/repository/auth/auth_repository.dart

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_bus_app/config/app_logger.dart';
import 'package:test_bus_app/models/user/user_model.dart';
import 'package:test_bus_app/network/interceptors/error_interceptor.dart';
import 'package:test_bus_app/services/auth/auth_service.dart';

class AuthRepository {
  final AuthService _authService;
  final AppLogger _logger;

  AuthRepository(this._authService, this._logger);

  Future<Either<AppException, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      _logger.info('Login attempt: $email');

      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      final supaUser = response.user;
      if (supaUser == null) {
        _logger.warning('Login failed: no user returned from Supabase');
        return Left(AppException(message: 'Login failed. Please try again.'));
      }

      final profile = await _fetchOrCreateProfile(supaUser);
      await _authService.saveUser(profile);
      _logger.info('Login success: ${profile.email} (uid: ${profile.id})');
      return Right(profile);
    } on AuthException catch (e) {
      _logger.warning('Login failed: ${e.message}');
      return Left(AppException(message: e.message));
    } catch (e) {
      _logger.error('Login error: $e');
      return Left(AppException(message: 'Unexpected error: $e'));
    }
  }

  Future<UserModel> _fetchOrCreateProfile(User supaUser) async {
    final data = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', supaUser.id)
        .maybeSingle();

    if (data != null) {
      _logger.info('Profile fetched from DB: ${data['email']}');
      return UserModel.fromJson(data);
    }

    // Profile missing (user existed before trigger) — upsert now
    _logger.warning(
        'Profile missing for ${supaUser.email}, creating profile...');
    final newProfile = <String, dynamic>{
      'id': supaUser.id,
      'email': supaUser.email ?? '',
      'name': supaUser.userMetadata?['name'] as String? ??
          supaUser.email?.split('@').first ??
          'User',
      'role': 'user',
      'created_at': supaUser.createdAt,
    };
    await Supabase.instance.client.from('profiles').upsert(newProfile);
    _logger.info('Profile created for ${supaUser.email}');
    return UserModel.fromJson({...newProfile, 'avatar_url': null});
  }

  Future<Either<AppException, Unit>> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      await _authService.clearSession();
      _logger.info('Logout success');
      return const Right(unit);
    } catch (e) {
      await _authService.clearSession();
      _logger.warning('Logout error (session cleared anyway): $e');
      return const Right(unit);
    }
  }

  bool get isLoggedIn =>
      Supabase.instance.client.auth.currentSession != null;

  // Uses locally cached profile — no DB call needed on startup
  UserModel? get cachedUser => _authService.getUser();
}
