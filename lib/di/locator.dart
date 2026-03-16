// lib/di/locator.dart
// Patterned exactly after the HRM app's GetIt locator

import 'package:get_it/get_it.dart';
import 'package:test_bus_app/bloc/auth/auth_bloc.dart';
import 'package:test_bus_app/config/app_logger.dart';
import 'package:test_bus_app/network/interceptors/auth_interceptor.dart';
import 'package:test_bus_app/network/interceptors/error_interceptor.dart';
import 'package:test_bus_app/network/network_api_service.dart';
import 'package:test_bus_app/repository/auth/auth_repository.dart';
import 'package:test_bus_app/repository/user/user_repository.dart';
import 'package:test_bus_app/repository/user/user_repository_impl.dart';
import 'package:test_bus_app/services/auth/auth_service.dart';
import 'package:test_bus_app/services/storage/storage_service.dart';


final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Config / Core
  getIt.registerLazySingleton<AppLogger>(() => AppLogger());

  // Storage
  final storageService = StorageService();
  await storageService.init();
  getIt.registerLazySingleton<StorageService>(() => storageService);

  // Network Interceptors
  getIt.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(getIt<StorageService>()));
  getIt.registerLazySingleton<ErrorInterceptor>(
      () => ErrorInterceptor(getIt<AppLogger>()));

  // Network Service
  getIt.registerLazySingleton<NetworkApiService>(() => NetworkApiService());

  // Services
  getIt.registerLazySingleton<AuthService>(
      () => AuthService(getIt<StorageService>(), getIt<AppLogger>()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      getIt<AuthService>(),
      getIt<AppLogger>(),
    ),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<AuthService>(), getIt<AppLogger>()),
  );

  // Blocs
  getIt.registerFactory(() => AuthBloc(getIt<AuthRepository>(), getIt<AppLogger>()));
}
