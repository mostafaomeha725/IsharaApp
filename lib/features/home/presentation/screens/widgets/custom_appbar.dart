import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_nav_bar.dart';

class CustomAppBarRow extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBarRow({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final bool isDark = themeController.themeMode == ThemeMode.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: isDark ? Colors.white : Colors.black),
            onPressed: onBack ??
                () {
                  final navBarState = CustomNavBar.of(context);
                  navBarState?.onWillPop();
                },
          ),
          const Spacer(),
          Text(
            title,
            style: font20w700.copyWith(
                color: isDark ? Colors.white : Colors.black),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
