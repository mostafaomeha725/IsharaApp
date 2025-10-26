import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/dark_colors.dart';
import 'package:isharaapp/core/theme/light_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpInputField extends StatelessWidget {
  const OtpInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final activeColor = isDark ? AppDarkColors.primary : AppLightColors.primary;
    final inactiveColor =
        isDark ? AppDarkColors.formFieldBorder : AppLightColors.formFieldBorder;
    final selectedColor =
        isDark ? AppDarkColors.secondary : AppLightColors.secondary;
    final backgroundColor =
        isDark ? const Color(0xff2b2b2b) : const Color(0xFFF6F6FE);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.w),
      child: PinCodeTextField(
        backgroundColor: backgroundColor,
        appContext: context,
        length: 4,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        cursorColor: activeColor,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          borderRadius: BorderRadius.circular(5.r),
          fieldHeight: 50.h,
          fieldWidth: 50.w,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          selectedColor: selectedColor,
        ),
        onChanged: (value) {},
      ),
    );
  }
}
