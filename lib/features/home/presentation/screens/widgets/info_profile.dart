import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class InfoProfile extends StatelessWidget {
  const InfoProfile({
    super.key,
    required this.gender,
  });

  final GenderTheme gender;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            AppAsset(
              assetName: Assets.iconProfileCircle,
              width: 85.w,
              height: 85.h,
            ),
            Positioned(
              child: AppAsset(
                  assetName: gender == GenderTheme.boy
                      ? Assets.boyEdit
                      : Assets.girlEdit),
              bottom: 0,
              right: 0,
            )
          ],
        ),
        SizedBox(width: 20.w),
        Column(
          children: [
            Text(
              'Mahmoud Elhenawy',
              style: font20w700,
            ),
            Text(
              'mahmoud202203355@gmailcom',
              style: font14w400,
            ),
          ],
        )
      ],
    );
  }
}
