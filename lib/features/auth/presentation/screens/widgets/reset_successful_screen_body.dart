import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class ResetSuccessfulScreenBody extends StatelessWidget {
  const ResetSuccessfulScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //  const AppSVG(assetName: Assets.newpass),
          AppText(
            'Reset Successful',
            style: font20w700,
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 8.h),
          AppText(
            'You can now log in to your account',
            style: font16w400,
            alignment: AlignmentDirectional.center,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 64.h,
          ),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).pushReplacement(Routes.loginScreen);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  'Login now',
                  style: font16w700,
                  textPadding: EdgeInsets.only(bottom: 2.h),
                ),
                Icon(
                  Icons.arrow_right_alt,
                  size: 28.sp,
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
