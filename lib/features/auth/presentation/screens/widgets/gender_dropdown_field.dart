import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/dark_colors.dart';
import 'package:isharaapp/core/theme/light_colors.dart';
import 'package:isharaapp/core/theme/styles.dart';

class GenderDropdownField extends StatelessWidget {
  const GenderDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String? value;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderColor =
        isDark ? AppDarkColors.formFieldBorder : AppLightColors.formFieldBorder;

    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.h, right: 6.h),
          child: const Icon(Icons.wc),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide(
            color: borderColor,
            width: 2.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide(
            color: borderColor,
            width: 2.w,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide(
            // ignore: deprecated_member_use
            color: borderColor.withOpacity(0.6),
            width: 2.w,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide(
            color: borderColor,
            width: 2.w,
          ),
        ),
        filled: true,
        fillColor: isDark ? Colors.transparent : Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),
      hint: Text(
        'Gender',
        style: font14w500.copyWith(
          color: isDark ? AppDarkColors.offwhite : Colors.black,
        ),
      ),
      items: [
        DropdownMenuItem(
            value: 'Male',
            child: Text(
              'Male',
              style: font14w400.copyWith(
                color: isDark ? AppDarkColors.offwhite : Colors.black,
              ),
            )),
        DropdownMenuItem(
            value: 'Female',
            child: Text(
              'Female',
              style: font14w400.copyWith(
                color: isDark ? AppDarkColors.offwhite : Colors.black,
              ),
            )),
      ],
      onChanged: onChanged,
      icon: Icon(
        Icons.arrow_drop_down,
        color: isDark ? AppDarkColors.offwhite : Colors.black,
      ),
      dropdownColor: isDark ? Colors.black : Colors.white,
    );
  }
}
