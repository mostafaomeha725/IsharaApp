import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_appbar.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;
    return Scaffold(
      backgroundColor: gender == GenderTheme.boy
          ? const Color(0xFF3A7CF2)
          : const Color(0xFFF24BB6),
      body: SafeArea(
        child: Stack(
          children: [
            AppAsset(
                assetName: gender == GenderTheme.boy
                    ? Assets.boySplash
                    : Assets.girlsplash),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const CustomAppBarRow(title: 'Choose Your Challenge'),
                  SizedBox(height: 25.h),
                  Text(
                    "Each level contains words made only\nfrom the letters you've learned in that\nlevel.\n\nStart with Level One and progress as\nyou master each set of letters.",
                    style: font20w700,
                  ),
                  SizedBox(height: 40.h),
                  AppButton(
                    text: 'Level One',
                    onPressed: () {
                      GoRouter.of(context).push(Routes.testLevelOneScreen);
                    },
                    color: Colors.white,
                    textColor: gender == GenderTheme.boy
                        ? const Color(0xFF3A7CF2)
                        : const Color(0xFFF24BB6),
                    textSize: 32.sp,
                    radius: 24.r,
                  ),
                  SizedBox(height: 20.h),
                  AppButton(
                    text: 'Level Two',
                    onPressed: () {
                      GoRouter.of(context).push(Routes.testLevelTwoScreen);
                    },
                    color: Colors.white,
                    textColor: gender == GenderTheme.boy
                        ? const Color(0xFF3A7CF2)
                        : const Color(0xFFF24BB6),
                    textSize: 32.sp,
                    radius: 24.r,
                  ),
                  SizedBox(height: 20.h),
                  AppButton(
                    text: 'Level Three',
                    onPressed: () {
                      GoRouter.of(context).push(Routes.testLevelThreeScreen);
                    },
                    color: Colors.white,
                    textColor: gender == GenderTheme.boy
                        ? const Color(0xFF3A7CF2)
                        : const Color(0xFFF24BB6),
                    textSize: 32.sp,
                    radius: 24.r,
                  ),
                  SizedBox(height: 20.h),
                  AppButton(
                    text: 'Level Four',
                    onPressed: () {
                      GoRouter.of(context).push(Routes.testLevelFourScreen);
                    },
                    color: Colors.white,
                    textColor: gender == GenderTheme.boy
                        ? const Color(0xFF3A7CF2)
                        : const Color(0xFFF24BB6),
                    textSize: 32.sp,
                    radius: 24.r,
                  ),
                  SizedBox(height: 50.h),
                  Text(
                      'Complete levels in order for the\n     best learning experience.',
                      style: font14w700)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
