// lib/repository/user/user_repository.dart
// Abstract contract for user data operations.

import 'package:dartz/dartz.dart';
import 'package:test_bus_app/models/user/user_model.dart';
import 'package:test_bus_app/network/interceptors/error_interceptor.dart';

abstract class UserRepository {
  Future<Either<AppException, UserModel>> getCurrentUser();
  Future<Either<AppException, UserModel>> updateProfile({
    required String name,
    String? avatarUrl,
  });
}
