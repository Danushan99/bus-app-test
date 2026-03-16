import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_bus_app/bloc/auth/auth_bloc.dart';
import 'package:test_bus_app/bloc/auth/auth_event.dart';
import 'package:test_bus_app/bloc/auth/auth_state.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';
import 'package:test_bus_app/common/widgets/app_button.dart';
import 'package:test_bus_app/common/widgets/app_loading_overlay.dart';
import 'package:test_bus_app/common/widgets/app_text_field.dart';
import 'package:test_bus_app/routes/app_routes_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.goNamed(AppRoutesConstants.homeScreenRouteName);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return AppLoadingOverlay(
          isLoading: state is AuthLoading,
          child: Scaffold(
            backgroundColor: AppColors.backgroundLight,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 48),

                          // Logo / Branding
                          Center(
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.directions_bus_rounded,
                                color: AppColors.surfaceLight,
                                size: 40,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          Text(
                            'Welcome Back!',
                            style: AppStyling.heading700Size24.copyWith(
                              fontSize: 28,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sign in to continue',
                            style: AppStyling.normal400Size16.copyWith(
                              color: AppColors.grey500,
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Email Field
                          AppTextField(
                            controller: _emailController,
                            hintText: 'Email address',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 16),

                          // Password Field
                          AppTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                          ),

                          const SizedBox(height: 24),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: AppStyling.normal500Size14.copyWith(
                                color: AppColors.grey500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),

                  // Login Button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 28),
                    child: AppButton(
                      label: 'Login',
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginRequested(
                                _emailController.text.trim(),
                                _passwordController.text,
                              ),
                            );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
