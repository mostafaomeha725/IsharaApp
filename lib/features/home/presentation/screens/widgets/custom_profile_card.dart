import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/item_personal_data.dart';

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard({
    super.key,
    required this.gender,
  });

  final GenderTheme gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 398.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pesonal Data',
              style: font16w700.copyWith(
                color: gender == GenderTheme.boy
                    ? const Color(0xFF3A7CF2)
                    : const Color(0xFFF24BB6),
              ),
            ),
            SizedBox(height: 16.h),
            ItemPersonalData(
              title: 'Name',
              subtitle: 'mahmoud elhenawy',
              image: gender == GenderTheme.boy
                  ? Assets.userSquareBoy
                  : Assets.userSquareGirl,
            ),
            ItemPersonalData(
              title: 'Email',
              subtitle: 'nourreldinahmed@gmail.com',
              image: gender == GenderTheme.boy
                  ? Assets.gmailBoy
                  : Assets.gmailGirl,
            ),
            ItemPersonalData(
              title: 'Date of birth',
              subtitle: '1/10/2004',
              image: gender == GenderTheme.boy
                  ? Assets.birthBoy
                  : Assets.birthGirl,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: ItemPersonalData(
                    title: 'Gender',
                    subtitle: 'Male',
                    image: gender == GenderTheme.boy
                        ? Assets.genderBoy
                        : Assets.genderGirl,
                  ),
                ),
                SizedBox(width: 12.w),
                AppButton(
                  text: 'Edit data',
                  onPressed: () {},
                  color: gender == GenderTheme.boy
                      ? const Color(0xFF3A7CF2)
                      : const Color(0xFFF24BB6),
                  radius: 16.r,
                  height: 40.h,
                  textSize: 15.sp,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
