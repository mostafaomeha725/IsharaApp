import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:isharaapp/features/splash/presentation/cubit/splash_state.dart';


class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateNext(BuildContext context, SplashState state) {
    if (!state.onboardingSeen) {
      context.go(Routes.onboardingScreen);
      return;
    }
    context.go(
      state.hasAuthToken ? Routes.customNavBar : Routes.loginScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final isDarkMode = themeController.themeMode == ThemeMode.dark;

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.ready) {
          _navigateNext(context, state);
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background texture
          Positioned.fill(
            child: AppAsset(
              assetName: isDarkMode
                  ? Assets.splashdark
                  : Assets.splashlight,
              fit: BoxFit.cover,
            ),
          ),

          // Centred logo with fade-in
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: AppAsset(
                assetName: isDarkMode ? Assets.darklogo : Assets.lightlogo,
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
