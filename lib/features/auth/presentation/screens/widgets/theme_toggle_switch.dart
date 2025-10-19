import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeToggleSwitch extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const ThemeToggleSwitch({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  @override
  State<ThemeToggleSwitch> createState() => _ThemeToggleSwitchState();
}

class _ThemeToggleSwitchState extends State<ThemeToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.isDarkMode ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(covariant ThemeToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDarkMode) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleTheme() => widget.onChanged(!widget.isDarkMode);

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    return GestureDetector(
      onTap: _toggleTheme,
      child: Container(
        width: 80.w,
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isDark ? Colors.black : Colors.white,
          border: Border.all(
            color: isDark ? Colors.white : Colors.black,
            width: 2.w,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Icons in background
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.wb_sunny_rounded,
                  color: isDark ? Colors.white54 : Colors.black,
                  size: 22.sp,
                ),
                Icon(
                  Icons.nightlight_round,
                  color: isDark ? Colors.white : Colors.black54,
                  size: 20.sp,
                ),
              ],
            ),
            // Moving circle
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white : Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                    color: isDark ? Colors.black : Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
