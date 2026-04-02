import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_screen_levels_map.dart';

class TestScreenLevelsHome extends StatelessWidget {
  const TestScreenLevelsHome({
    super.key,
    required this.themeController,
    required this.onOpenLevel,
  });

  final ThemeController themeController;
  final ValueChanged<int> onOpenLevel;

  @override
  Widget build(BuildContext context) {
    final bool isDark = themeController.themeMode == ThemeMode.dark;

    return Padding(
      key: const ValueKey('testLevelsMain'),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const CustomAppBarRow(title: 'Choose Your Challenge'),
          SizedBox(height: 5.h),
          AppText(
            "Each level contains\nwords made only from the letters\nyou've learned in that level",
            textAlign: TextAlign.center,
            style: font20w700.copyWith(
              fontSize: 16.sp,
              height: 1.35,
              color: isDark ? Colors.white : const Color(0xff333333),
            ),
            alignment: AlignmentDirectional.center,
            overflow: TextOverflow.visible,
          ),
          TestScreenLevelsMap(
            themeMode: themeController.themeMode,
            onOpenLevel: onOpenLevel,
          ),
        ],
      ),
    );
  }
}
