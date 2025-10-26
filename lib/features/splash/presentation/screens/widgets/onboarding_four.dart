import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class OnboardingFour extends StatelessWidget {
  const OnboardingFour({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          const Spacer(flex: 1),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Build Words & Confidence",
              style: font32w700,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            flex: 5,
            child: AppAsset(
              assetName: themeController.themeMode == ThemeMode.dark
                  ? Assets.littledark
                  : Assets.littlelight,
              height: 360.h,
              width: 360.w,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Progress from letters to complete.\n words with our sequential recognition \ntechnology, developing practical communication\n skills.",
            style: font16w400,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
