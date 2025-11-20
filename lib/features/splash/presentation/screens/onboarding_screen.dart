import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/splash/presentation/screens/widgets/custom_indicator.dart';
import 'package:isharaapp/features/splash/presentation/screens/widgets/onboarding_five.dart';
import 'package:isharaapp/features/splash/presentation/screens/widgets/onboarding_footer.dart';
import 'package:isharaapp/features/splash/presentation/screens/widgets/onboarding_four.dart';
import 'package:isharaapp/features/splash/presentation/screens/widgets/onboarding_one.dart';
import 'package:isharaapp/features/splash/presentation/screens/widgets/onboarding_three.dart';
import 'package:isharaapp/features/splash/presentation/screens/widgets/onboarding_two.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _controller = PageController();
  int index = 0;

  void onboardingSeen(BuildContext context) {
    GoRouter.of(context).push(Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    return Scaffold(
      backgroundColor: ThemeController.of(context).themeMode == ThemeMode.dark
          ? Color(0xff2b2b23)
          : Color(0xfffafafa),
      body: SafeArea(
        child: Stack(
          children: [
            AppAsset(
              assetName: themeController.themeMode == ThemeMode.dark
                  ? Assets.splashdark
                  : Assets.splashlight,
            ),
            Column(
              children: [
                const SizedBox(height: 100),
                Expanded(
                  child: PageView(
                    onPageChanged: (value) {
                      setState(() => index = value);
                    },
                    controller: _controller,
                    children: const [
                      OnboardingOne(),
                      OnboardingTwo(),
                      OnboardingThree(),
                      OnboardingFour(),
                      OnboardingFive(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (i) => CustomIndicator(active: index == i),
                  ),
                ),
                const SizedBox(height: 40),
                OnboardingFooter(controller: _controller, index: index),
                const SizedBox(height: 20),
              ],
            ),
            if (index < 4)
              Positioned(
                top: 21,
                right: 20,
                child: TextButton(
                  onPressed: () => onboardingSeen(context),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: themeController.themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: Center(
                child: AppAsset(
                  assetName: themeController.themeMode == ThemeMode.light
                      ? Assets.lightappbarlogo
                      : Assets.darkappbarlogo,
                  width: 248.w,
                  height: 70.h,
                ),
              ),
            ),
            if (index == 0)
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: Icon(
                    themeController.themeMode == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: themeController.themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: themeController.toggleTheme,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
