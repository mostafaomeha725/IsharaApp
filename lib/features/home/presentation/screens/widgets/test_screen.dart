import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/dotted_path_painter.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/level_bubble.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AppAsset(
              assetName: themeController.themeMode == ThemeMode.dark
                  ? Assets.splashdark
                  : Assets.splashlight,
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const CustomAppBarRow(title: 'Choose Your Challenge'),
                  SizedBox(height: 5.h),
                  Text(
                    "Each level contains\nwords made only from the letters\nyou've learned in that level",
                    textAlign: TextAlign.center,
                    style: font20w700.copyWith(
                      //fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      height: 1.35,
                      color: themeController.themeMode == ThemeMode.dark
                          ? Colors.white
                          : const Color(0xff333333),
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      final w = constraints.maxWidth;
                      final h = constraints.maxHeight;

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: DottedPathPainter(
                                  themeMode: themeController.themeMode),
                            ),
                          ),
                          Positioned(
                            top: h * 0.05,
                            left: w * 0.06,
                            child: LevelBubble(
                              assetName: Assets.book1,
                              label: 'Level One',
                              onTap: () => GoRouter.of(context)
                                  .push(Routes.testLevelOneScreen),
                            ),
                          ),
                          Positioned(
                            top: h * 0.18,
                            right: w * 0.06,
                            child: LevelBubble(
                              label: 'Level Two',
                              onTap: () => GoRouter.of(context)
                                  .push(Routes.testLevelTwoScreen),
                              assetName: Assets.book2,
                            ),
                          ),
                          Positioned(
                            top: h * 0.33,
                            left: w * 0.06,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.h),
                                LevelBubble(
                                  label: 'Level Three',
                                  onTap: () => GoRouter.of(context)
                                      .push(Routes.testLevelThreeScreen),
                                  assetName: Assets.book3,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: h * 0.52,
                            right: w * 0.06,
                            child: LevelBubble(
                              assetName: Assets.book4,
                              label: 'Level Four',
                              onTap: () => GoRouter.of(context)
                                  .push(Routes.testLevelFourScreen),
                            ),
                          ),
                          Positioned(
                            bottom: 5.h,
                            left: w * 0.5 - 60.w,
                            child: Center(
                              child: AppAsset(
                                assetName: Assets.passImage,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
