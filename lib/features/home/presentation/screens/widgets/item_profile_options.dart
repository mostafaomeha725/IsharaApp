import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class ItemProfileOptions extends StatelessWidget {
  const ItemProfileOptions({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
  });

  final String title;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            AppAsset(
              assetName: image,
              width: 30.w,
              height: 30.h,
            ),
            SizedBox(width: 24.w),
            Text(
              title,
              style: font12w400.copyWith(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
