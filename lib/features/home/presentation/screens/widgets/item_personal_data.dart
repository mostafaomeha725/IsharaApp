import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class ItemPersonalData extends StatelessWidget {
  const ItemPersonalData({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h), // مسافة بين العناصر
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppAsset(
            assetName: image,
            width: 30.w,
            height: 30.h,
          ),
          SizedBox(width: 12.w), // مسافة بين الصورة والنصوص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: font12w700.copyWith(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: font12w400.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
