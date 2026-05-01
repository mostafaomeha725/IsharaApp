import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

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
                  _buildStepItem(
                    context: context,
                    icon: Icons.phone_android_rounded,
                    iconColor: const Color(0xFF8B5CF6), // Purple
                    title: 'Setting up interface',
                  ),
                  _buildStepItem(
                    context: context,
                    icon: Icons.animation_rounded,
                    iconColor: const Color(0xFF3B82F6), // Blue
                    title: 'Loading animations',
                  ),
                  _buildStepItem(
                    context: context,
                    icon: Icons.memory_rounded, // AI Chip
                    iconColor: const Color(0xFF06B6D4), // Cyan
                    title: 'Loading AI model',
                  ),
                  _buildStepItem(
                    context: context,
                    icon: Icons.camera_alt_outlined,
                    iconColor: const Color(0xFF10B981), // Green
                    title: 'Starting camera',
                  ),

                  const Spacer(),

                  // Tip warning box
                  _buildTipBox(context),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          Row(
            children: [
              // Icon Box
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode
                      ? iconColor.withOpacity(0.1)
                      : iconColor.withOpacity(0.15),
                ),
                child: Icon(icon, color: iconColor, size: 20.r),
              ),
              SizedBox(width: 16.w),
              // Title
              Expanded(
                child: AppText(
                  title,
                  style: font14w500.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                  alignment: AlignmentDirectional.centerStart,
                ),
              ),
              // Loading Dots (simulated progress)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStatusDot(iconColor, true),
                  SizedBox(width: 6.w),
                  _buildStatusDot(iconColor.withOpacity(0.3), false),
                  SizedBox(width: 6.w),
                  _buildStatusDot(iconColor.withOpacity(0.3), false),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(
            color: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.05),
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDot(Color color, bool isActive) {
    return Container(
      width: 6.r,
      height: 6.r,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTipBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(0xFF1E1E2A).withOpacity(0.8)
            : Colors.deepPurple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color:
              isDarkMode ? Colors.white12 : Colors.deepPurple.withOpacity(0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: const Color(0xFF8B5CF6), // Purple
            size: 24.r,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  'Tip',
                  style: font14w500.copyWith(
                    color: const Color(0xFF8B5CF6),
                    fontWeight: FontWeight.w700,
                  ),
                  alignment: AlignmentDirectional.centerStart,
                ),
                SizedBox(height: 6.h),
                AppText(
                  'For best performance, please keep the app open while we prepare everything.',
                  style: font14w500.copyWith(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                    fontSize: 12.sp,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  alignment: AlignmentDirectional.centerStart,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
