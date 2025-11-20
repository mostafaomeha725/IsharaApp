import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Color backgroundColor;
  final VoidCallback onArrowTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 398.w,
      height: 249.h,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: font20w700.copyWith(color: Color(0xff333333)),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            style: font14w400.copyWith(color: Color(0xff333333)),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppAsset(
                assetName: image,
                height: 135.h,
                width: 285.w,
              ),
              GestureDetector(
                onTap: onArrowTap,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppAsset(
                    color: Color(0xff333333),
                    assetName: Assets.arrowgirl,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
