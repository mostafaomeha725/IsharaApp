import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_nav_bar.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const HomeAppbar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final bool isDark = themeController.themeMode == ThemeMode.dark;

    final Color iconColor = isDark ? Colors.white : Colors.black;
    final Color titleColor = isDark ? Colors.white : Colors.black;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 20.sp,
          color: iconColor,
        ),
        onPressed: onBack ??
            () {
              final navBarState = CustomNavBar.of(context);
              navBarState?.onWillPop();
            },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: font20w700.copyWith(color: titleColor),
      ),
    );
  }
}
