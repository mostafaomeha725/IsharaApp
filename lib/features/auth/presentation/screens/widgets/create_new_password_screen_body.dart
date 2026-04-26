import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/dark_colors.dart';
import 'package:isharaapp/core/theme/light_colors.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/app_form_field.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/auth/presentation/cubit/auth_cubit.dart';

class CreateNewPasswordScreenBody extends StatefulWidget {
  const CreateNewPasswordScreenBody({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  State<CreateNewPasswordScreenBody> createState() =>
      _CreateNewPasswordScreenBodyState();
}

class _CreateNewPasswordScreenBodyState
    extends State<CreateNewPasswordScreenBody> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeController = ThemeController.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }

        if (state.status == AuthStatus.success &&
            state.action == AuthAction.forgotPasswordReset) {
          GoRouter.of(context).go(Routes.resetSuccessful);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                AppAsset(
                  assetName: themeController.themeMode == ThemeMode.dark
                      ? Assets.splashdark
                      : Assets.splashlight,
                ),
                Column(
                  children: [
                    SizedBox(height: 66.h),
                    const AppAsset(
                        assetName: Assets.laptopwithpasswordnotification),
                    SizedBox(height: 12.h),
                    AppText(
                      'Reset your password',
                      style: font24w700,
                      alignment: AlignmentDirectional.center,
                    ),
                    SizedBox(height: 12.h),
                    AppText(
                      'Here\'s a tip: Use a combination of\nNumbers, Uppercase, lowercase and Special characters',
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
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: isDarkMode
                              ? AppDarkColors.offwhite
                              : AppLightColors.black,
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
                    AppFormField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      maxLines: 1,
                      obsecureText: obscureConfirmPassword,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.h, right: 6.h),
                        child: const Icon(Icons.lock_outline),
                      ),
                      radius: 22.r,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: isDarkMode
                              ? AppDarkColors.offwhite
                              : AppLightColors.black,
                          size: 22.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 32.h),
                    AppButton(
                      text: state.isLoading ? 'Loading...' : 'Reset Password',
                      onPressed: state.isLoading
                          ? null
                          : () {
                              final password = passwordController.text;
                              final confirmPassword =
                                  confirmPasswordController.text;

                              if (password.length < 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Password must be at least 6 characters.'),
                                  ),
                                );
                                return;
                              }

                              if (password != confirmPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords do not match.'),
                                  ),
                                );
                                return;
                              }

                              context.read<AuthCubit>().forgotPasswordReset(
                                    email: widget.email,
                                    otp: widget.otp,
                                    password: password,
                                  );
                            },
                      color: isDarkMode ? Colors.white : Colors.black,
                      textColor: isDarkMode ? Colors.black : Colors.white,
                      height: 50.h,
                      radius: 22.r,
                    ),
                    SizedBox(height: 42.h),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
