// lib/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_bus_app/routes/app_routes_constants.dart';
import 'package:test_bus_app/screens/auth/login_screen.dart';
import 'package:test_bus_app/screens/home/home_screen.dart';
import 'package:test_bus_app/screens/profile/profile_screen.dart';
import 'package:test_bus_app/screens/splash/splash_screen.dart';
import 'package:test_bus_app/screens/seat_selection/seat_selection_screen.dart';
import 'package:test_bus_app/screens/boarding_dropping/boarding_dropping_screen.dart';
import 'package:test_bus_app/screens/confirmation/confirmation_screen.dart';
import 'package:test_bus_app/screens/booking_list/booking_list_screen.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutesConstants.splashScreenRouteName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoutesConstants.loginScreenRouteName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoutesConstants.homeScreenRouteName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: AppRoutesConstants.profileScreenRouteName,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/seat_selection',
        name: AppRoutesConstants.seatSelectionScreenRouteName,
        builder: (context, state) {
          final busData = state.extra as Map<String, dynamic>? ?? {};
          return SeatSelectionScreen(busData: busData);
        },
      ),
      GoRoute(
        path: '/boarding_dropping',
        name: AppRoutesConstants.boardingDroppingScreenRouteName,
        builder: (context, state) {
          final busData = state.extra as Map<String, dynamic>? ?? {};
          return BoardingDroppingScreen(busData: busData);
        },
      ),
      GoRoute(
        path: '/confirmation',
        name: AppRoutesConstants.confirmationScreenRouteName,
        builder: (context, state) {
          final busData = state.extra as Map<String, dynamic>? ?? {};
          return ConfirmationScreen(busData: busData);
        },
      ),
      GoRoute(
        path: '/booking_list',
        name: AppRoutesConstants.bookingListScreenRouteName,
        builder: (context, state) {
          final busData = state.extra as Map<String, dynamic>? ?? {};
          return BookingListScreen(busData: busData);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
}
