import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class TextRowStartLearning extends StatelessWidget {
  const TextRowStartLearning({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 6.h, right: 8.w),
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              AppText(
                title,
                style: font16w700.copyWith(
                  color: const Color(0xffECF2FE),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
