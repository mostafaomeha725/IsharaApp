import 'package:camera/camera.dart'; // 1. إضافة مكتبة الكاميرا
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/auth/presentation/screens/check_mail_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/login_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/register_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/practise_lesson_details_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/test_level_four_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/test_level_one_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/test_level_three_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/test_level_two_screen.dart';
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
  required List<CameraDescription> cameras, // استقبال قائمة الكاميرات
}) {
  return GoRouter(
    initialLocation: Routes.splashScreen,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    observers: [
      if (isDevEnviroment()) ChuckerFlutter.navigatorObserver,
      SentryNavigatorObserver(),
      customGoRouterObserver,
    ],
    routes: [
      GoRoute(
        path: Routes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.onboardingScreen,
        builder: (context, state) => const OnboardScreen(),
      ),
      GoRoute(
        path: Routes.resetScreen,
        builder: (context, state) => const ResetScreen(),
      ),
      GoRoute(
        path: Routes.checkMailScreen,
        builder: (context, state) {
          if (state.extra is Map<String, dynamic>) {
            final extra = state.extra as Map<String, dynamic>;
            final email = extra['email']?.toString() ?? '';
            final flow = extra['flow'] == 'verify'
                ? CheckMailFlow.emailVerification
                : CheckMailFlow.forgotPassword;

            return CheckMailScreen(
              email: email,
              flow: flow,
            );
          }

          final email = (state.extra as String?) ?? '';
          return CheckMailScreen(
            email: email,
            flow: CheckMailFlow.forgotPassword,
          );
        },
      ),
      GoRoute(
        path: Routes.createNewPasswordScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email']?.toString() ?? '';
          final otp = extra?['otp']?.toString() ?? '';

          return CreateNewPasswordScreen(
            email: email,
            otp: otp,
          );
        },
      ),
      GoRoute(
        path: Routes.resetSuccessful,
        builder: (context, state) => const ResetSuccessfulScreen(),
      ),
      GoRoute(
        path: Routes.customNavBar,
        builder: (context, state) => const CustomNavBar(),
      ),

      // 🔹 شاشة تفاصيل التدريب
      GoRoute(
        path: Routes.practisedetails,
        builder: (context, state) {
          final letter = state.extra as String;

          // لو مفيش كاميرات خالص ما نحاولش نستخدم first
          if (cameras.isEmpty) {
            return const Scaffold(
              body: Center(
                child: Text('لا توجد كاميرا متاحة على هذا الجهاز'),
              ),
            );
          }

          // نبحث عن الكاميرا الأمامية، ولو مش موجودة ناخد أي كاميرا
          final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () => cameras.first,
          );

          return PractiseLessonDetailsScreen(
            letter: letter,
            camera: frontCamera,
          );
        },
      ),

      // 🔹 المستوى الأول
      GoRoute(
        path: Routes.testLevelOneScreen,
        builder: (context, state) {
          if (cameras.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('لا توجد كاميرا متاحة')),
            );
          }

          final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () => cameras.first,
          );

          return TestLevelOneScreen(camera: frontCamera);
        },
      ),

      // 🔹 المستوى الثاني
      GoRoute(
        path: Routes.testLevelTwoScreen,
        builder: (context, state) {
          if (cameras.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('لا توجد كاميرا متاحة')),
            );
          }

          final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () => cameras.first,
          );

          return TestLevelTwoScreen(camera: frontCamera);
        },
      ),

      // 🔹 المستوى الثالث
      GoRoute(
        path: Routes.testLevelThreeScreen,
        builder: (context, state) {
          if (cameras.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('لا توجد كاميرا متاحة')),
            );
          }

          final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () => cameras.first,
          );

          return TestLevelThreeScreen(camera: frontCamera);
        },
      ),

      // 🔹 المستوى الرابع
      GoRoute(
        path: Routes.testLevelFourScreen,
        builder: (context, state) {
          if (cameras.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('لا توجد كاميرا متاحة')),
            );
          }

          final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () => cameras.first,
          );

          return TestLevelFourScreen(camera: frontCamera);
        },
      ),
    ],
  );
}
