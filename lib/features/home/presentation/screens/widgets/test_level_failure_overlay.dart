import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class TestLevelFailureOverlay extends StatelessWidget {
  const TestLevelFailureOverlay({
    super.key,
    required this.message,
    required this.onRetry,
    required this.isDarkMode,
  });

  final String message;
  final VoidCallback onRetry;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.redAccent, size: 44.sp),
          SizedBox(height: 16.h),
          AppText(
            'Failed to start test',
            style: font20w700.copyWith(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 10.h),
          AppText(
            message,
            style: font16w700.copyWith(
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          AppButton(
            text: 'Retry',
            onPressed: onRetry,
            color: isDarkMode ? Colors.white : Colors.black,
            textColor: isDarkMode ? Colors.black : Colors.white,
            radius: 24.r,
          ),
        ],
      ),
    );
  }
}
