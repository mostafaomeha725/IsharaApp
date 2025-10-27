import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: onBack ??
                () {
                  final navBarState = CustomNavBar.of(context);
                  navBarState?.onWillPop();
                },
          ),
          const Spacer(),
          Text(
            title,
            style: font20w700.copyWith(color: Colors.white),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
