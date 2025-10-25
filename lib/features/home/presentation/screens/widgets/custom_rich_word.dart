import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';

class CustomRichWord extends StatelessWidget {
  final String word;

  const CustomRichWord({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;
    if (word.isEmpty) return const SizedBox.shrink();
    final firstLetter = word[0].toUpperCase();
    final rest = word.substring(1);
    return RichText(
      text: TextSpan(
        text: firstLetter,
        style: font32w700.copyWith(
          color: gender == GenderTheme.boy
              ? const Color(0xFF152D57)
              : const Color(0xFF571B42),
          fontSize: 90.sp,
        ),
        children: [
          TextSpan(
            text: rest,
            style: font32w700.copyWith(
              fontSize: 90.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
