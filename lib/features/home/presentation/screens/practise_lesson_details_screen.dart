import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class PractiseLessonDetailsScreen extends StatelessWidget {
  const PractiseLessonDetailsScreen({super.key, required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('practise Details', style: font20w700),
          SizedBox(height: 12.h),
          AppText(
            'Here you can view lesson contents, examples, and practice exercises.',
            style: font14w400,
          ),
          SizedBox(height: 20.h),
          Center(
            child: ElevatedButton(
              onPressed: onBack,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: const Text('Back'),
            ),
          ),
        ],
      ),
    );
  }
}
