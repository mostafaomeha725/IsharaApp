import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String completetext;
  final double value;
  final bool isinto;
  final bool isPractice;
  final void Function()? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.completetext,
    required this.value,
    this.isinto = true,
    this.isPractice = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final Color mainColor = themeController.themeMode == ThemeMode.dark
        ? Colors.white
        : Colors.black;

    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Text(
                        title,
                        style: font12w400.copyWith(
                          color: const Color(0xffECF2FE),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AppText(
                      subtitle,
                      style: font16w400.copyWith(color: mainColor),
                    ),
                    AppText(
                      completetext,
                      style: font12w400.copyWith(color: mainColor),
                    ),
                    SizedBox(height: 4.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.sp),
                      child: Padding(
                        padding: EdgeInsets.only(right: 72.w),
                        child: LinearProgressIndicator(
                          value: value,
                          color: mainColor,
                          backgroundColor: const Color(0xffC4C4C4),
                          minHeight: 4.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isPractice
                  ? SizedBox(
                      width: 40.w,
                      height: 40.h,
                      child: Icon(
                        Icons.arrow_right_alt,
                        size: 38.sp,
                        color: mainColor,
                      ))
                  : isinto
                      ? Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: mainColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 32.sp,
                          ),
                        )
                      : SizedBox(
                          width: 40.w,
                          height: 40.h,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
