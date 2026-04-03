import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/features/home/domain/entities/profile_user_entity.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/item_personal_data.dart';

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard({
    super.key,
    required this.user,
    required this.onEditName,
    this.isLoading = false,
  });

  final ProfileUserEntity user;
  final VoidCallback onEditName;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 398.w,
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
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
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            ItemPersonalData(
              title: 'Name',
              subtitle: user.fullName,
              image: Assets.iconProfile,
            ),
            ItemPersonalData(
              title: 'Email',
              subtitle: user.email,
              image: Assets.iconEmail,
            ),
            ItemPersonalData(
              title: 'Date of birth',
              subtitle: user.dateOfBirth,
              image: Assets.iconBirthday,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: ItemPersonalData(
                    title: 'Gender',
                    subtitle: user.gender,
                    image: Assets.iconGender,
                  ),
                ),
                SizedBox(width: 12.w),
                AppButton(
                  text: isLoading ? 'Saving...' : 'Edit data',
                  onPressed: isLoading ? null : onEditName,
                  color: Colors.black,
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
