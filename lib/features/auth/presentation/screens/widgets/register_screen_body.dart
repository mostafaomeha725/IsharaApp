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
import 'package:isharaapp/features/auth/presentation/screens/widgets/data_of_birth_field.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/gender_dropdown_field.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/theme_toggle_switch.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  String? selectedGender;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? errorMessage;

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final isDarkMode = themeController.themeMode == ThemeMode.dark;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error && state.message != null) {
          _showErrorSnackBar(state.message!);
        }

        if (state.status == AuthStatus.success &&
            state.action == AuthAction.register) {
          final email = emailController.text.trim();
          GoRouter.of(context).go(
            Routes.checkMailScreen,
            extra: {
              'email': email,
              'flow': 'verify',
            },
          );
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
                    Row(
                      children: [
                        Expanded(
                          child: AppFormField(
                            maxLines: 1,
                            controller: firstNameController,
                            hintText: 'First name',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 16.h, right: 6.h),
                              child: const Icon(Icons.person),
                            ),
                            radius: 22.r,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: AppFormField(
                            controller: lastNameController,
                            maxLines: 1,
                            hintText: 'Last name',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 16.h, right: 6.h),
                              child: const Icon(Icons.person),
                            ),
                            radius: 22.r,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    AppFormField(
                      maxLines: 1,
                      controller: emailController,
                      hintText: 'Email Address',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 6.h, left: 16.h),
                        child: const Icon(Icons.email),
                      ),
                      radius: 22.r,
                    ),
                    SizedBox(height: 18.h),
                    AppFormField(
                      controller: passwordController,
                      hintText: 'Password',
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
                    SizedBox(height: 18.h),
                    AppFormField(
                      controller: confirmPasswordController,
                      hintText: 'Re-write password',
                      obsecureText: obscureConfirmPassword,
                      maxLines: 1,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.h, right: 6.h),
                        child: const Icon(Icons.lock),
                      ),
                      radius: 22.r,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: isDarkMode
                              ? AppDarkColors.offwhite
                              : Colors.black,
                          size: 22.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    if (errorMessage != null) ...[
                      SizedBox(height: 6.h),
                      AppText(
                        errorMessage!,
                        style: font12w400.copyWith(color: Colors.red),
                      ),
                    ],
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        Expanded(
                          child: DateOfBirthField(
                              controller: dateOfBirthController),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: GenderDropdownField(
                            value: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    AppButton(
                      color: themeController.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      text: state.isLoading ? 'Signing up...' : 'Sign up',
                      textColor: themeController.themeMode == ThemeMode.dark
                          ? Colors.black
                          : Colors.white,
                      height: 50.h,
                      radius: 22.r,
                      onPressed: state.isLoading
                          ? null
                          : () {
                              final firstName = firstNameController.text.trim();
                              final lastName = lastNameController.text.trim();
                              final email = emailController.text.trim();
                              final password = passwordController.text;
                              final confirmPassword =
                                  confirmPasswordController.text;
                              final dateOfBirth =
                                  dateOfBirthController.text.trim();

                              if (firstName.isEmpty ||
                                  lastName.isEmpty ||
                                  email.isEmpty ||
                                  password.isEmpty ||
                                  confirmPassword.isEmpty ||
                                  dateOfBirth.isEmpty ||
                                  selectedGender == null) {
                                _showErrorSnackBar(
                                  'Please fill all required fields.',
                                );
                                return;
                              }

                              if (password != confirmPassword) {
                                setState(() {
                                  errorMessage =
                                      'Please make sure your passwords match.';
                                });
                                return;
                              }

                              setState(() => errorMessage = null);

                              context.read<AuthCubit>().register(
                                    firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    gender: selectedGender!,
                                    dateOfBirth: dateOfBirth,
                                  );
                            },
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          'Already have an account? ',
                          style: font14w500.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppDarkColors.offwhite
                                    : const Color(0xffC4C4C4),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => GoRouter.of(context).pop(),
                          child: AppText(
                            'Sign in',
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
                      onChanged: (_) => themeController.toggleTheme(),
                    ),
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
