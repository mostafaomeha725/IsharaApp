import 'package:flutter/material.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.controller,
    required this.index,
    required this.onFinish,
  });

  final PageController controller;
  final int index;
  final Future<void> Function() onFinish;

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
              onPressed: onFinish,
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
