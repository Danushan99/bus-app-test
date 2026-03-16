import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bus_app/bloc/auth/auth_bloc.dart';
import 'package:test_bus_app/bloc/auth/auth_event.dart';
import 'package:test_bus_app/bloc/auth/auth_state.dart';
import 'package:test_bus_app/config/app_config.dart';
import 'package:test_bus_app/config/app_logger.dart';
import 'package:test_bus_app/config/theme/app_theme.dart';
import 'package:test_bus_app/di/locator.dart';
import 'package:test_bus_app/routes/app_router.dart';
import 'package:test_bus_app/routes/app_routes_constants.dart';

Future<void> mainCommon(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Config
  AppConfig.initialize(config);

  // Initialize dependency injection
  await setupLocator();

  final logger = getIt<AppLogger>();
  logger.info(
      "Starting app in ${AppConfig.environment.name.toUpperCase()} mode hitting ${AppConfig.baseUrl}");

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(CheckAuthStatus())),
      ],
      child: Builder(
        builder: (context) {
          // Listen for global auth changes (logout auto-navigation)
          context.read<AuthBloc>().stream.listen((state) {
            if (state is Unauthenticated) {
              AppRoutes.router.goNamed(AppRoutesConstants.loginScreenRouteName);
            }
          });

          return MaterialApp.router(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: AppConfig.isDebug,
            routerDelegate: AppRoutes.router.routerDelegate,
            routeInformationParser: AppRoutes.router.routeInformationParser,
            routeInformationProvider: AppRoutes.router.routeInformationProvider,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
