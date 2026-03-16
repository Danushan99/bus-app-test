// lib/screens/splash/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:test_bus_app/bloc/auth/auth_bloc.dart';
import 'package:test_bus_app/bloc/auth/auth_state.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/routes/app_routes_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      final state = context.read<AuthBloc>().state;
      if (state is Authenticated) {
        context.goNamed(AppRoutesConstants.homeScreenRouteName);
      } else {
        context.goNamed(AppRoutesConstants.loginScreenRouteName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bus Lottie animation
            Lottie.asset(
              'assets/animations/busload.json',
              width: 220,
              height: 220,
              fit: BoxFit.contain,
              repeat: true,
            ),
            const SizedBox(height: 24),
            // App name
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'i',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                      letterSpacing: -1,
                    ),
                  ),
                  const TextSpan(
                    text: 'bus',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
