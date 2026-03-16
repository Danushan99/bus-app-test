// lib/repository/user/user_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_bus_app/config/app_logger.dart';
import 'package:test_bus_app/models/user/user_model.dart';
import 'package:test_bus_app/network/interceptors/error_interceptor.dart';
import 'package:test_bus_app/repository/user/user_repository.dart';
import 'package:test_bus_app/services/auth/auth_service.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthService _authService;
  final AppLogger _logger;

  UserRepositoryImpl(this._authService, this._logger);

  @override
  Future<Either<AppException, UserModel>> getCurrentUser() async {
    try {
      final supaUser = Supabase.instance.client.auth.currentUser;
      if (supaUser == null) {
        return Left(AppException(message: 'Not authenticated'));
      }

      final data = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', supaUser.id)
          .single();

      final user = UserModel.fromJson(data);
      await _authService.saveUser(user);
      _logger.info('getCurrentUser: fetched profile for ${user.email}');
      return Right(user);
    } on PostgrestException catch (e) {
      _logger.error('getCurrentUser DB error: ${e.message}');
      return Left(AppException(message: e.message));
    } catch (e) {
      _logger.error('getCurrentUser error: $e');
      return Left(AppException(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<AppException, UserModel>> updateProfile({
    required String name,
    String? avatarUrl,
  }) async {
    try {
      final supaUser = Supabase.instance.client.auth.currentUser;
      if (supaUser == null) {
        return Left(AppException(message: 'Not authenticated'));
      }

      final updates = <String, dynamic>{
        'name': name,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
      };

      final data = await Supabase.instance.client
          .from('profiles')
          .update(updates)
          .eq('id', supaUser.id)
          .select()
          .single();

      final updated = UserModel.fromJson(data);
      await _authService.saveUser(updated);
      _logger.info('updateProfile: name updated to "${updated.name}"');
      return Right(updated);
    } on PostgrestException catch (e) {
      _logger.error('updateProfile DB error: ${e.message}');
      return Left(AppException(message: e.message));
    } catch (e) {
      _logger.error('updateProfile error: $e');
      return Left(AppException(message: 'Unexpected error: $e'));
    }
  }
}
