import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/app_form_field.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/auth/presentation/cubit/auth_cubit.dart';

class ResetScreenBody extends StatefulWidget {
  const ResetScreenBody({super.key});

  @override
  State<ResetScreenBody> createState() => _ResetScreenBodyState();
}

class _ResetScreenBodyState extends State<ResetScreenBody> {
  final TextEditingController emailController = TextEditingController();

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final isDarkMode = themeController.themeMode == ThemeMode.dark;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error && state.message != null) {
          _showSnackBar(state.message!);
        }

        if (state.status == AuthStatus.success &&
            state.action == AuthAction.forgotPasswordSend) {
          final email = emailController.text.trim();
          GoRouter.of(context).push(
            Routes.checkMailScreen,
            extra: email,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            AppAsset(
              assetName: isDarkMode ? Assets.splashdark : Assets.splashlight,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 96.h),
                    AppAsset(
                      assetName: Assets.dataSecurity,
                      width: 300.w,
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
                      text: state.isLoading ? 'Loading...' : 'Continue',
                      color: isDarkMode ? Colors.white : Colors.black,
                      textColor: isDarkMode ? Colors.black : Colors.white,
                      onPressed: state.isLoading
                          ? null
                          : () {
                              final email = emailController.text.trim();
                              if (email.isEmpty || !_isValidEmail(email)) {
                                _showSnackBar(
                                  'Please enter a valid email address.',
                                );
                                return;
                              }

                              context.read<AuthCubit>().forgotPasswordSend(
                                    email: email,
                                  );
                            },
                      height: 50.h,
                      radius: 22.r,
                    ),
                    SizedBox(height: 72.h),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
