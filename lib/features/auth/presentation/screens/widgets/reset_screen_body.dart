import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/app_form_field.dart';
import 'package:isharaapp/core/widgets/app_svg.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class ResetScreenBody extends StatefulWidget {
  const ResetScreenBody({super.key});

  @override
  State<ResetScreenBody> createState() => _ResetScreenBodyState();
}

class _ResetScreenBodyState extends State<ResetScreenBody> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppAsset(
            assetName: Assets.forgetPasswordlight,
            width: 250.w,
            height: 250.h,
          ),
          AppText(
            'Forget Password ',
            style: font20w700,
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 4.h),
          AppText(
            'Please enter your email to reset the password',
            style: font16w400,
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 20.h),
          AppFormField(
            controller: emailController,
            hintText: 'Email Address',
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 6.h, left: 16.h),
              child: Icon(Icons.email, size: 24.sp),
            ),
            radius: 22.r,
          ),
          SizedBox(height: 20.h),
          AppButton(
            text: 'Continue',
            onPressed: () {
              GoRouter.of(context).push(Routes.checkMailScreen);
            },
            height: 50.h,
            radius: 22.r,
          ),
          SizedBox(
            height: 72.h,
          )
        ],
      ),
    );
  }
}
