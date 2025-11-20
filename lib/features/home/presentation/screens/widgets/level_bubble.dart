import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class LevelBubble extends StatelessWidget {
  final String label;
  final String assetName;
  final VoidCallback? onTap;

  const LevelBubble({
    required this.label,
    required this.assetName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center, // ← مركز كل اللي جوه
          children: [
            /// النص في النص
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),

            Positioned(
              top: -50.h,
              left: -47.w,
              child: AppAsset(
                assetName: assetName,
                width: 75.w,
                height: 75.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
