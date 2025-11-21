import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class InfoProfile extends StatelessWidget {
  const InfoProfile({
    super.key,
    required ThemeMode themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final bool isDark = themeController.themeMode == ThemeMode.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            AppAsset(
              assetName:
                  isDark ? Assets.iconProfileCircle : Assets.iconProfileCircleL,
              width: 85.w,
              height: 85.h,
            ),
            Positioned(
              child: AppAsset(
                assetName: Assets.iconEdit,
              ),
              bottom: 0,
              right: 0,
            )
          ],
        ),
        SizedBox(height: 16.h),
        Column(
          children: [
            Text(
              'Mahmoud Elhenawy',
              style: font20w700.copyWith(
                  color: isDark ? Colors.white : Colors.black),
            ),
          ],
        )
      ],
    );
  }
}
