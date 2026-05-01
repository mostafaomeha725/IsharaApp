import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final AppSessionManager _sessionManager = AppSessionManager();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), _navigateNext);
  }

  Future<void> _navigateNext() async {
    final onboardingSeen = await _sessionManager.isOnboardingSeen();
    final hasAuthToken = await _sessionManager.hasAuthToken();

    if (!mounted) return;

    if (!onboardingSeen) {
      GoRouter.of(context).go(Routes.onboardingScreen);
      return;
    }

    GoRouter.of(context).go(
      hasAuthToken ? Routes.customNavBar : Routes.loginScreen,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          AppAsset(
            assetName: themeController.themeMode == ThemeMode.dark
                ? Assets.splashdark
                : Assets.splashlight,
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: AppAsset(
                assetName: themeController.themeMode == ThemeMode.dark
                    ? Assets.darklogo
                    : Assets.lightlogo,
                width: 250.w,
                height: 250.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
