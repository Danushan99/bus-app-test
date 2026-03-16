// lib/bloc/auth/auth_bloc.dart
// Matches the HRM AuthBloc pattern

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bus_app/bloc/auth/auth_event.dart';
import 'package:test_bus_app/bloc/auth/auth_state.dart';
import 'package:test_bus_app/config/app_logger.dart';
import 'package:test_bus_app/repository/auth/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final AppLogger _logger;

  AuthBloc(this._authRepository, this._logger) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) {
    emit(AuthLoading());
    if (_authRepository.isLoggedIn) {
      final user = _authRepository.cachedUser;
      if (user != null) {
        _logger.info('Auth status: already logged in (${user.email})');
        emit(Authenticated(user));
      } else {
        _logger.info('Auth status: session exists but no user data');
        emit(Unauthenticated());
      }
    } else {
      _logger.info('Auth status: no active session');
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _authRepository.login(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (error) => emit(AuthError(error.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _authRepository.logout();
    emit(Unauthenticated());
  }
}
