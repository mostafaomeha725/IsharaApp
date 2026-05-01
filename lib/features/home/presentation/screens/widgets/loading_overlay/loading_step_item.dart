import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'loading_status_dot.dart';

class LoadingStepItem extends StatelessWidget {
  final bool isDarkMode;
  final IconData icon;
  final Color iconColor;
  final String title;

  const LoadingStepItem({
    super.key,
    required this.isDarkMode,
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
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
                  LoadingStatusDot(color: iconColor, isActive: true),
                  SizedBox(width: 6.w),
                  LoadingStatusDot(color: iconColor, isActive: false),
                  SizedBox(width: 6.w),
                  LoadingStatusDot(color: iconColor, isActive: false),
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
}
