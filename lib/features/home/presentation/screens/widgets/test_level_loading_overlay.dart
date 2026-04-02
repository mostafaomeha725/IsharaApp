import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.h,
            width: 50.h,
            child: const CircularProgressIndicator(strokeWidth: 3),
          ),
          SizedBox(height: 25.h),
          AppText(
            'Starting Camera...',
            style: font18w700.copyWith(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 10.h),
          AppText(
            'Please wait...',
            style: font14w500.copyWith(color: Colors.grey),
            alignment: AlignmentDirectional.center,
          ),
        ],
      ),
    );
  }
}
