import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class OnboardingFive extends StatelessWidget {
  const OnboardingFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Expanded(
            flex: 5,
            child: AppAsset(
              assetName: Assets.onboardingfive,
              height: 360.h,
              width: 360.w,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Begin Your Journey",
            style: font32w700,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Text(
            "Follow our step-by-step video lessons\n with clear demonstrations and repetition  \nto build your foundation in\n  sign language.",
            style: font16w400,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
