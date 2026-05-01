import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class LoadingTipBox extends StatelessWidget {
  final bool isDarkMode;

  const LoadingTipBox({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
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
