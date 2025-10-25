import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/dark_colors.dart';
import 'package:isharaapp/core/theme/light_colors.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_form_field.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class CreateNewPasswordScreenBody extends StatefulWidget {
  const CreateNewPasswordScreenBody({super.key});

  @override
  State<CreateNewPasswordScreenBody> createState() =>
      _CreateNewPasswordScreenBodyState();
}

class _CreateNewPasswordScreenBodyState
    extends State<CreateNewPasswordScreenBody> {
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //  const AppSVG(assetName: Assets.securitycuate),
          AppText(
            'Reset your password',
            style: font24w700,
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 12.h),
          AppText(
            'Here’s a tip: Use a combination of\nNumbers, Uppercase, lowercase and Special characters',
            style: font16w400,
            maxLines: 3,
            textAlign: TextAlign.center,
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 40.h),
          AppFormField(
            controller: passwordController,
            hintText: 'New Password',
            maxLines: 1,
            obsecureText: obscurePassword,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16.h, right: 6.h),
              child: const Icon(Icons.lock),
            ),
            radius: 22.r,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color:
                    isDarkMode ? AppDarkColors.offwhite : AppLightColors.black,
                size: 22.sp,
              ),
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
          ),
          SizedBox(height: 32.h),
          AppButton(
            text: 'Reset Password',
            onPressed: () {
              GoRouter.of(context).push(Routes.resetSuccessful);
            },
            height: 50.h,
            radius: 22.r,
          ),
          SizedBox(
            height: 42.h,
          )
        ],
      ),
    );
  }
}
