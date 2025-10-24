import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
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
    final gender = GenderController.of(context).genderTheme;

    return Container(
      width: 398.w,
      height: 249.h,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: gender == GenderTheme.boy
            ? const Color(0xFFECF2FE)
            : const Color(0xffFEF1F9),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
            style: font20w700.copyWith(
              color: gender == GenderTheme.boy
                  ? const Color(0xFF3A7CF2)
                  : const Color(0xffF24BB6),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            style: font14w400.copyWith(
              color: gender == GenderTheme.boy
                  ? const Color(0xFF3A7CF2)
                  : const Color(0xffF24BB6),
            ),
          ),
          const Spacer(), // بدل Expanded
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
                    assetName: gender == GenderTheme.boy
                        ? Assets.arrowboy
                        : Assets.arrowgirl,
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
