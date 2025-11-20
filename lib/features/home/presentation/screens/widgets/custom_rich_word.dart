import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';

class CustomRichWord extends StatelessWidget {
  final String word;

  const CustomRichWord({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    if (word.isEmpty) return const SizedBox.shrink();
    final firstLetter = word[0].toUpperCase();
    final rest = word.substring(1);
    return RichText(
      text: TextSpan(
        text: firstLetter,
        style: font32w700.copyWith(
          color: themeController.themeMode == ThemeMode.dark
              ? const Color(0xFFFAFAFA)
              : const Color(0xFF333333),
          fontSize: 90.sp,
        ),
        children: [
          TextSpan(
            text: rest,
            style: font32w700.copyWith(
              fontSize: 90.sp,
              color: themeController.themeMode == ThemeMode.dark
                  ? const Color(0xFFB3B3B3)
                  : const Color(0xFF737373),
            ),
          ),
        ],
      ),
    );
  }
}
