import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';

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
    return AppBar(
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
