import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/dark_colors.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/app_form_field.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/auth/presentation/cubit/auth_cubit.dart';
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

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool _isUnverifiedEmailMessage(String message) {
    final text = message.toLowerCase();
    return text.contains('email not verified') ||
        text.contains('verify your email');
  }

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error && state.message != null) {
          if (state.action == AuthAction.login &&
              _isUnverifiedEmailMessage(state.message!)) {
            final email = emailcontroller.text.trim();
            GoRouter.of(context).push(
              Routes.checkMailScreen,
              extra: {
                'email': email,
                'flow': 'verify',
              },
            );
            return;
          }

          _showErrorSnackBar(state.message!);
        }

        if (state.status == AuthStatus.success) {
          GoRouter.of(context).go(Routes.customNavBar);
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
                    SizedBox(height: 36.h),
                    AppAsset(
                      assetName: themeController.themeMode == ThemeMode.dark
                          ? Assets.darklogo
                          : Assets.lightlogo,
                      width: 250.w,
                      height: 250.h,
                    ),
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
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: isDarkMode
                              ? AppDarkColors.offwhite
                              : Colors.black,
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
                          color: Theme.of(context).brightness ==
                                  Brightness.dark
                              ? AppDarkColors.offwhite
                              : const Color(0xffC4C4C4),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AppButton(
                      text: state.isLoading ? 'Signing in...' : 'Sign in',
                      color: themeController.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      textColor: themeController.themeMode == ThemeMode.dark
                          ? Colors.black
                          : Colors.white,
                      onPressed: state.isLoading
                          ? null
                          : () {
                              final email = emailcontroller.text.trim();
                              final password = passwordcontroller.text;

                              if (email.isEmpty || password.isEmpty) {
                                _showErrorSnackBar(
                                  'Email and password are required.',
                                );
                                return;
                              }

                              if (!_isValidEmail(email)) {
                                _showErrorSnackBar(
                                  'Please enter a valid email address.',
                                );
                                return;
                              }

                              context.read<AuthCubit>().login(
                                    email: email,
                                    password: password,
                                  );
                            },
                      height: 50.h,
                      radius: 22.r,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          'Don\'t have an account ?  ',
                          style: font14w500.copyWith(
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? AppDarkColors.offwhite
                                : const Color(0xffC4C4C4),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .push(Routes.registerScreen);
                          },
                          child: AppText(
                            'Register now',
                            style: font14w700.copyWith(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppDarkColors.offwhite
                                  : const Color(0xffC4C4C4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    ThemeToggleSwitch(
                      isDarkMode: isDarkMode,
                      onChanged: (value) {
                        themeController.toggleTheme();
                      },
                    ),
                    SizedBox(height: 24.h),
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
