import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/widgets/app_form_field.dart';

class DateOfBirthField extends StatefulWidget {
  const DateOfBirthField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppFormField(
      maxLines: 1,
      controller: widget.controller,
      hintText: 'Birthday',
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 16.h, right: 6.h),
        child: const Icon(Icons.calendar_month),
      ),
      suffixIcon: Icon(
        Icons.arrow_drop_down,
        color: isDark ? Colors.white : Colors.black,
        size: 26.sp,
      ),
      radius: 22.r,
      readOnly: true,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: isDark
                    ? const ColorScheme.dark(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        surface: Colors.black,
                        onSurface: Colors.white,
                      )
                    : const ColorScheme.light(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                dialogTheme: DialogThemeData(
                    backgroundColor:
                        isDark ? const Color(0xFF121212) : Colors.white),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          widget.controller.text =
              '${picked.day}/${picked.month}/${picked.year}';
        }
      },
    );
  }
}
