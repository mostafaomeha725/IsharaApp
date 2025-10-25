import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';

class CustomAppBarRow extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBarRow({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: onBack ?? () => Navigator.pop(context),
          ),
          const Spacer(),
          Text(
            title,
            style: font20w700,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
