import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/bouncing_widgets.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Color backgroundColor;
  final VoidCallback onTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BounceIt(
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              title,
              style: font20w700.copyWith(color: const Color(0xff333333)),
            ),
            SizedBox(height: 6.h),
            AppText(
              subtitle,
              style: font14w400.copyWith(color: const Color(0xff333333)),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppAsset(
                  assetName: image,
                  height: 120.h,
                  width: 250.w,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppAsset(
                    color: const Color(0xff333333),
                    assetName: Assets.arrowgirl,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
