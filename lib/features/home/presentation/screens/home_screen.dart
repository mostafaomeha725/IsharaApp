import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onNavigateToTab});
  final Function(int)?
      onNavigateToTab; //دس الفانكشن اللي بتعملي نافجين جوا ال nav bar كانه تايمر

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final bool isDark = themeController.themeMode == ThemeMode.dark;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppAsset(
              assetName: themeController.themeMode == ThemeMode.dark
                  ? Assets.splashdark
                  : Assets.splashlight,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Night',
                          style: font20w700.copyWith(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    GestureDetector(
                      onTap: () {
                        onNavigateToTab?.call(1);
                      },
                      child: HomeCard(
                        title: "Learn",
                        subtitle:
                            'Explore new lessons and expand your knowledge',
                        image: themeController.themeMode == ThemeMode.dark
                            ? Assets.learnBoy
                            : Assets.learngirl,
                        backgroundColor:
                            themeController.themeMode == ThemeMode.dark
                                ? const Color(0xFFECF2FE)
                                : const Color(0xffFEF1F9),
                        onArrowTap: () {},
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () {
                        onNavigateToTab?.call(2);
                      },
                      child: HomeCard(
                        title: "Practice",
                        subtitle:
                            'Reinforce what you have learned with Quick exercises',
                        image: themeController.themeMode == ThemeMode.dark
                            ? Assets.practieboy
                            : Assets.practiegirl,
                        backgroundColor:
                            themeController.themeMode == ThemeMode.dark
                                ? const Color(0xFFECF2FE)
                                : const Color(0xffFEF1F9),
                        onArrowTap: () {},
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () {
                        onNavigateToTab?.call(3);
                      },
                      child: HomeCard(
                        title: "Test yourself with AI Bot",
                        subtitle:
                            'Explore new lessons and expand your knowledge',
                        image: themeController.themeMode == ThemeMode.dark
                            ? Assets.testboy
                            : Assets.testgirl,
                        backgroundColor:
                            themeController.themeMode == ThemeMode.dark
                                ? const Color(0xFFECF2FE)
                                : const Color(0xffFEF1F9),
                        onArrowTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
