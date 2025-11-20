import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

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
              assetName: Assets.onboardingthree,
              height: 360.h,
              width: 360.w,
            ),
          ),
          Text(
            "Interactive Practice",
            style: font32w700,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Text(
            "Use our AI gesture recognition \nto practice signs and receive instant feedback  \nwith encouraging animations and helpful \n corrections.",
            style: font16w400,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
