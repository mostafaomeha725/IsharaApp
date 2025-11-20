import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

class NavBarItem extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: isSelected
            ? Matrix4.translationValues(0, -5.h, 0)
            : Matrix4.identity(),
        width: 50.w,
        height: 50.h,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Container(
                width: 40.w,
                height: 40.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            AppAsset(
              assetName: icon,
              width: 30.w,
              height: 30.h,
              color: isSelected ? Color(0xff252525) : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
