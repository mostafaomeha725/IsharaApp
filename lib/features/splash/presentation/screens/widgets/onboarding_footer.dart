import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';

class HiveManager {
  Future<void> setBool(String key, bool value) async {
    // TODO: replace this stub with the real persistence implementation (e.g., Hive or SharedPreferences).
    return;
  }
}

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.controller,
    required this.index,
  });

  final PageController controller;
  final int index;

  Future<void> onboardingSeen(BuildContext context) async {
    await HiveManager().setBool('onboarding', true);

    GoRouter.of(context).push(Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (index > 0)
            TextButton(
              onPressed: () {
                controller.animateToPage(
                  index - 1,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              },
              child: Text(
                'Back',
                style: TextStyle(
                  color: themeController.themeMode == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            const SizedBox(width: 60),
          if (index < 4)
            TextButton(
              onPressed: () {
                controller.animateToPage(
                  index + 1,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              },
              child: Text(
                'Next',
                style: TextStyle(
                  color: themeController.themeMode == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            TextButton(
              onPressed: () => onboardingSeen(context),
              child: Text(
                'Begin',
                style: TextStyle(
                  color: themeController.themeMode == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
