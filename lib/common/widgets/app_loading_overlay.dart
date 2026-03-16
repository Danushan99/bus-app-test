import 'package:flutter/material.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:lottie/lottie.dart';

/// A reusable full-screen loading overlay that displays a Lottie animation.
///
/// Usage — wrap your screen's Scaffold (or any widget) with this:
/// ```dart
/// AppLoadingOverlay(
///   isLoading: state is SomeLoadingState,
///   child: YourWidget(),
/// )
/// ```
///
/// Place your Lottie JSON file at: assets/animations/loading.json
class AppLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  /// Optional path to a Lottie animation file.
  /// Defaults to 'assets/animations/loading.json'.
  final String animationPath;

  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.animationPath = 'assets/animations/busload.json',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.4),
              child: Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Lottie.asset(
                    animationPath,
                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
