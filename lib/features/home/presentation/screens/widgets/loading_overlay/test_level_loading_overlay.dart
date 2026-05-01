import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

import 'loading_step_item.dart';
import 'loading_tip_box.dart';

class TestLevelLoadingOverlay extends StatelessWidget {
  const TestLevelLoadingOverlay({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Splash background image
          AppAsset(
            assetName: isDarkMode ? Assets.splashdark : Assets.splashlight,
            fit: BoxFit.cover,
          ),

          // Main Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // iOS style loading indicator
                  CupertinoActivityIndicator(
                    color: isDarkMode ? Colors.white : Colors.black,
                    radius: 25.r,
                  ),
                  SizedBox(height: 32.h),

                  // Titles
                  AppText(
                    'Preparing your camera',
                    style: font18w700.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 22.sp,
                      letterSpacing: 0.5,
                    ),
                    alignment: AlignmentDirectional.center,
                  ),
                  SizedBox(height: 8.h),
                  AppText(
                    'This may take a few seconds',
                    style: font14w500.copyWith(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                    alignment: AlignmentDirectional.center,
                  ),
                  SizedBox(height: 48.h),

                  // Steps List
                  LoadingStepItem(
                    isDarkMode: isDarkMode,
                    icon: Icons.phone_android_rounded,
                    iconColor: const Color(0xFF8B5CF6), // Purple
                    title: 'Setting up interface',
                  ),
                  LoadingStepItem(
                    isDarkMode: isDarkMode,
                    icon: Icons.animation_rounded,
                    iconColor: const Color(0xFF3B82F6), // Blue
                    title: 'Loading animations',
                  ),
                  LoadingStepItem(
                    isDarkMode: isDarkMode,
                    icon: Icons.memory_rounded, // AI Chip
                    iconColor: const Color(0xFF06B6D4), // Cyan
                    title: 'Loading AI model',
                  ),
                  LoadingStepItem(
                    isDarkMode: isDarkMode,
                    icon: Icons.camera_alt_outlined,
                    iconColor: const Color(0xFF10B981), // Green
                    title: 'Starting camera',
                  ),

                  const Spacer(),

                  // Tip warning box
                  LoadingTipBox(isDarkMode: isDarkMode),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
