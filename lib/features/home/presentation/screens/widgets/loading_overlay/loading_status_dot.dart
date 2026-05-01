import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingStatusDot extends StatelessWidget {
  final Color color;
  final bool isActive;

  const LoadingStatusDot({
    super.key,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6.r,
      height: 6.r,
      decoration: BoxDecoration(
        color: isActive ? color : color.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}
