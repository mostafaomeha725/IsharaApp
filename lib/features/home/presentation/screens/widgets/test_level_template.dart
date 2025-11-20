import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_rich_word.dart';

class TestLevelTemplate extends StatelessWidget {
  final String title;
  final String word;
  final String accuracy;
  final VoidCallback onBackPressed;

  const TestLevelTemplate({
    super.key,
    required this.title,
    required this.word,
    required this.accuracy,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AppAsset(
              assetName: themeController.themeMode == ThemeMode.dark
                  ? Assets.splashdark
                  : Assets.splashlight,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBarRow(title: title, onBack: onBackPressed),
                    SizedBox(height: 16.h),
                    CustomRichWord(word: word),
                    SizedBox(height: 16.h),
                    _buildVideoBox(
                        context, themeController.themeMode == ThemeMode.dark),
                    SizedBox(height: 30.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Practice Tips:",
                        style: font16w700.copyWith(
                            color: themeController.themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _buildTip(context, "Find good lighting facing your hands"),
                    _buildTip(context, "Keep your hand centered in the frame"),
                    _buildTip(context, "Make sure all fingers are visible"),
                    _buildTip(context, "Don't rush - form the sign carefully"),
                    SizedBox(height: 16.h),
                    AppButton(
                      text: 'back to letter lesson',
                      onPressed: onBackPressed,
                      textColor: themeController.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      color: Colors.transparent,
                      radius: 32.r,
                      borderColor: themeController.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoBox(BuildContext context, bool isDarkMode) {
    return Container(
      width: double.infinity,
      height: 400.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: AppAsset(
              width: double.infinity,
              height: 460.h,
              fit: BoxFit.cover,
              assetName: Assets.boy,
            ),
          ),
          Positioned(
            top: 12.h,
            child: Column(
              children: [
                Text("word 1 of 10",
                    style: font14w500.copyWith(color: Colors.white)),
                SizedBox(height: 4.h),
                Text("00:05", style: font14w500.copyWith(color: Colors.white)),
              ],
            ),
          ),
          Text("Analyzing...",
              style: font14w500.copyWith(color: Colors.white.withOpacity(0.9))),
          Positioned(
            bottom: 24.h,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8.h),
                Text(
                  "Accuracy",
                  style: font14w500.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Text(
                  accuracy,
                  style:
                      font32w700.copyWith(fontSize: 36.sp, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Row(
        children: [
          Text("• ",
              style: font18w700.copyWith(
                  color: ThemeController.of(context).themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black)),
          Expanded(
            child: Text(
              text,
              style: font16w700.copyWith(
                  color: ThemeController.of(context).themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
