import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/auth/presentation/screens/check_mail_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/login_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/register_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/reset_screen.dart';
import 'package:isharaapp/main.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '/core/env.dart';
import 'route_observer.dart';
import 'route_paths.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

GoRouter createRouter({
  required VoidCallback onToggleTheme,
  required ThemeMode themeMode,
}) {
  return GoRouter(
    initialLocation: Routes.loginScreen,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    observers: [
      if (isDevEnviroment()) ChuckerFlutter.navigatorObserver,
      SentryNavigatorObserver(),
      // customGoRouterObserver,
    ],
    routes: [
      GoRoute(
        path: Routes.splashScreen,
        builder: (context, state) =>
            SplashScreen(onToggleTheme: onToggleTheme, themeMode: themeMode),
      ),
      GoRoute(
          path: Routes.loginScreen,
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: Routes.registerScreen,
          builder: (context, state) => const RegisterScreen()),
      GoRoute(
          path: Routes.resetScreen,
          builder: (context, state) => const ResetScreen()),
      GoRoute(
          path: Routes.checkMailScreen,
          builder: (context, state) => const CheckMailScreen()),
      GoRoute(
          path: Routes.createNewPasswordScreen,
          builder: (context, state) => const CreateNewPasswordScreen()),
    ],
  );
}
