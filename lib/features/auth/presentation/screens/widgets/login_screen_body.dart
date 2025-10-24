import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/dark_colors.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_form_field.dart';
import 'package:isharaapp/core/widgets/app_svg.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/theme_toggle_switch.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final isDarkMode = themeController.themeMode == ThemeMode.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 48.w),
      child: Column(
        children: [
          SizedBox(height: 36.h),
          const AppSVG(assetName: Assets.logo),
          SizedBox(height: 18.h),
          AppFormField(
            controller: emailcontroller,
            hintText: 'Email Address',
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 6.h, left: 16.h),
              child: Icon(Icons.email, size: 24.sp),
            ),
            radius: 22.r,
          ),
          SizedBox(height: 18.h),
          AppFormField(
            maxLines: 1,
            controller: passwordcontroller,
            hintText: 'Password',
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16.h, right: 6.h),
              child: const Icon(Icons.lock),
            ),
            obsecureText: obscurePassword,
            radius: 22.r,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: isDarkMode ? AppDarkColors.offwhite : Colors.black,
                size: 22.sp,
              ),
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push(Routes.resetScreen);
            },
            child: AppText(
              'Forgotten your password..?',
              style: font14w500.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppDarkColors.offwhite
                    : const Color(0xffC4C4C4),
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).brightness == Brightness.dark
                    ? AppDarkColors.offwhite
                    : const Color(0xffC4C4C4),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          AppButton(
            text: 'Sign in',
            onPressed: () {},
            height: 50.h,
            radius: 22.r,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                'Don’t have an account ?  ',
                style: font14w500.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppDarkColors.offwhite
                      : const Color(0xffC4C4C4),
                ),
              ),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(Routes.registerScreen);
                },
                child: AppText(
                  'Register now',
                  style: font14w700.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppDarkColors.offwhite
                        : const Color(0xffC4C4C4),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          ThemeToggleSwitch(
            isDarkMode: isDarkMode,
            onChanged: (value) {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
