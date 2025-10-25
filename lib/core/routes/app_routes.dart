import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/auth/presentation/screens/check_mail_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/login_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/register_screen.dart';

import 'package:isharaapp/features/home/presentation/screens/start_learning_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_nav_bar.dart';
import 'package:isharaapp/features/splash/presentation/screens/onboarding_screen.dart';
import 'package:isharaapp/features/splash/presentation/screens/splash_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/reset_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/reset_successful_screen.dart';
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
    initialLocation: Routes.splashScreen,
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
          builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: Routes.loginScreen,
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: Routes.registerScreen,
          builder: (context, state) => const RegisterScreen()),
      GoRoute(
          path: Routes.onboardingScreen,
          builder: (context, state) => const OnboardScreen()),
      GoRoute(
          path: Routes.resetScreen,
          builder: (context, state) => const ResetScreen()),
      GoRoute(
          path: Routes.checkMailScreen,
          builder: (context, state) => const CheckMailScreen()),
      GoRoute(
          path: Routes.createNewPasswordScreen,
          builder: (context, state) => const CreateNewPasswordScreen()),
      GoRoute(
          path: Routes.resetSuccessful,
          builder: (context, state) => const ResetSuccessfulScreen()),
      GoRoute(
        path: Routes.customNavBar,
        builder: (context, state) => const CustomNavBar(),
      ),
    ],
  );
}
