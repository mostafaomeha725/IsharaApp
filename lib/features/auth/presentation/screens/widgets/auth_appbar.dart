import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const AuthAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);

    return AppBar(
      backgroundColor: themeController.themeMode == ThemeMode.dark
          ? const Color(0xff2b2b2b)
          : null,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(title, style: font20w700),
    );
  }
}
