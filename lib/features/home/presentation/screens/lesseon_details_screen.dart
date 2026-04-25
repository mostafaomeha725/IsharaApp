import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/words_details.dart';

class LesseonDetailsScreen extends StatelessWidget {
  const LesseonDetailsScreen({
    super.key,
    required this.onBack,
    required this.letter,
    this.onNext,
    this.onTestTap,
    this.isCompleting = false,
  });

  final VoidCallback onBack;
  final VoidCallback? onNext;
  final VoidCallback? onTestTap;
  final String letter;
  final bool isCompleting;

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final bool isDark = themeController.themeMode == ThemeMode.dark;

    final Color mainColor = isDark ? Colors.white : Colors.black;
    final Color secondaryColor = isDark ? Colors.white70 : Colors.black87;
    final Color buttonBg = isDark ? Colors.white : Colors.black;
    final Color buttonText = isDark ? Colors.black : Colors.white;

    final String singleLetter = letter.split(' ').last;
    final String letterAsset = Assets.letterAssetFor(singleLetter);
    final data = lessonsData[singleLetter] ??
        {
          'title': letter,
          'steps': 'No data available for this letter.',
          'mistakes': '',
        };

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 52.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppAsset(assetName: Assets.boyandgirlworkoncomputer),
                  AppAsset(assetName: Assets.onlinemeating),
                ],
              ),
              SizedBox(height: 24.h),
              AppAsset(
                assetName: letterAsset,
                height: 340.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'KEY STEPS:',
                  style: font20w700.copyWith(color: mainColor),
                ),
              ),
              SizedBox(height: 8.h),
              AppText(
                data['steps']!,
                style: font16w700.copyWith(color: secondaryColor),
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: 40.h),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'COMMON MISTAKES:',
                  style: font20w700.copyWith(color: mainColor),
                ),
              ),
              SizedBox(height: 8.h),
              AppText(
                data['mistakes']!,
                style: font16w700.copyWith(color: secondaryColor),
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: 32.h),
              AppText(
                'Try practicing along with the image!',
                style: font20w700.copyWith(color: mainColor),
                alignment: AlignmentDirectional.center,
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: AppButton(
                      text: 'Go Back',
                      onPressed: onBack,
                      height: 42.h,
                      borderColor: buttonBg,
                      color: buttonBg,
                      textColor: buttonText,
                      textSize: 15.sp,
                      textWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 10,
                    child: AppButton(
                      text: isCompleting ? 'Saving...' : 'Next Letter',
                      onPressed: isCompleting ? null : onNext,
                      height: 42.h,
                      color: buttonBg,
                      textColor: buttonText,
                      textSize: 15.sp,
                      textWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (onTestTap != null) ...[
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: onTestTap,
                  child: Container(
                    width: double.infinity,
                    height: 42.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF48CAE4)],
                      ),
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.videocam_rounded,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Test This Letter',
                          style: font16w700.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
