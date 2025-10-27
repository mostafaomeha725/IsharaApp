import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/text_row_start_learning.dart';

class StartLearningScreen extends StatelessWidget {
  final VoidCallback onGoBack;
  final void Function()? onPressed;

  const StartLearningScreen({
    super.key,
    required this.onGoBack,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;
    final genderColor = gender == GenderTheme.boy
        ? const Color(0xFF3A7CF2)
        : const Color(0xFFF24BB6);
    final buttonColor = gender == GenderTheme.boy
        ? const Color(0xFF152D57)
        : const Color(0xFF571B42);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 76.h), // مسافة بعد الـ AppBar
                AppText('1. Watch & Learn',
                    style: font20w700.copyWith(color: Colors.white)),
                SizedBox(height: 8.h),
                const TextRowStartLearning(
                    title: 'Start with video lessons for each letter. '),
                const TextRowStartLearning(
                    title: 'Pay attention to hand shape and movement'),
                SizedBox(height: 40.h),
                AppText('2. Practice with AI',
                    style: font20w700.copyWith(color: Colors.white)),
                SizedBox(height: 8.h),
                const TextRowStartLearning(
                    title: 'Use your camera to practice signs.'),
                const TextRowStartLearning(
                    title: 'Our AI will give you instant feedback.'),
                SizedBox(height: 40.h),
                AppText('3. Build Words',
                    style: font20w700.copyWith(color: Colors.white)),
                SizedBox(height: 8.h),
                const TextRowStartLearning(
                    title:
                        'Combine letters you have learned\nto form real words.'),
                SizedBox(height: 40.h),
                AppText('4. Take Your Time',
                    style: font20w700.copyWith(color: Colors.white)),
                SizedBox(height: 8.h),
                const TextRowStartLearning(title: 'Go at your own pace.'),
                const TextRowStartLearning(
                    title: 'Repeat lessons until you feel confident.'),
                const TextRowStartLearning(
                    title: 'Ready to begin your sign language journey?'),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: AppButton(
                        text: 'Go Back',
                        onPressed: onGoBack,
                        height: 42.h,
                        borderColor: Colors.white,
                        textColor: genderColor,
                        color: Colors.white,
                        textSize: 15.sp,
                        textWeight: FontWeight.w500,
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 10,
                      child: AppButton(
                        text: 'Start Now!',
                        onPressed: onPressed,
                        height: 42.h,
                        color: buttonColor,
                        textSize: 15,
                        textWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HomeAppbar(
              title: 'Start Learning',
              onBack: onGoBack,
            ),
          ),
        ],
      ),
    );
  }
}
