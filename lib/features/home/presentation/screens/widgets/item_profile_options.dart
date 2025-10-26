import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class ItemProfileOptions extends StatelessWidget {
  const ItemProfileOptions(
      {super.key, required this.title, required this.image});
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;

    return Row(
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
              color: gender == GenderTheme.boy
                  ? const Color(0xFF3A7CF2)
                  : const Color(0xFFF24BB6)),
        ),
      ],
    );
  }
}
