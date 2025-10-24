import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';

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
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 20.sp,
          color: Colors.white,
        ),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: font20w700.copyWith(color: Colors.white),
      ),
    );
  }
}
