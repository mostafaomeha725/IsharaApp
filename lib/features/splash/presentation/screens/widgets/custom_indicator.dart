import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key, required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 5.h,
      width: active ? 25.w : 5.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: active ? Color(0xFF3A7CF2) : Color(0xFFC4C4C4),
      ),
    );
  }
}
