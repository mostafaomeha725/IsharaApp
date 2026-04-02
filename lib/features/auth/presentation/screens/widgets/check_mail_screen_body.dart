import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:isharaapp/features/auth/presentation/screens/check_mail_screen.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/otp_input_field.dart';

class CheckMailScreenBody extends StatefulWidget {
  const CheckMailScreenBody({
    super.key,
    required this.email,
    required this.flow,
  });

  final String email;
  final CheckMailFlow flow;

  @override
  State<CheckMailScreenBody> createState() => _CheckMailScreenBodyState();
}

class _CheckMailScreenBodyState extends State<CheckMailScreenBody> {
  int seconds = 60;
  Timer? _timer;
  String _otp = '';

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    setState(() => seconds = 60);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final isDarkMode = themeController.themeMode == ThemeMode.dark;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }

        if (state.status == AuthStatus.success &&
            state.action == AuthAction.forgotPasswordVerify &&
            widget.flow == CheckMailFlow.forgotPassword) {
          GoRouter.of(context).push(
            Routes.createNewPasswordScreen,
            extra: {
              'email': widget.email,
              'otp': _otp,
            },
          );
        }

        if (state.status == AuthStatus.success &&
            state.action == AuthAction.verifyOtp &&
            widget.flow == CheckMailFlow.emailVerification) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? 'Email verified.')),
          );
          GoRouter.of(context).go(Routes.loginScreen);
        }

        if (state.status == AuthStatus.success &&
            state.action == AuthAction.forgotPasswordResendOtp &&
            widget.flow == CheckMailFlow.forgotPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? 'OTP resent.')),
          );
        }

        if (state.status == AuthStatus.success &&
            state.action == AuthAction.resendOtp &&
            widget.flow == CheckMailFlow.emailVerification) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? 'OTP resent.')),
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
                    SizedBox(height: 72.h),
                    AppAsset(
                      assetName: Assets.email,
                      width: 280.w,
                      height: 250.h,
                    ),
                    AppText(
                      'Check your mail',
                      style: font20w700,
                      alignment: AlignmentDirectional.center,
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      widget.flow == CheckMailFlow.emailVerification
                          ? 'Your email is not verified yet. Enter the OTP sent to your email.'
                          : 'We just sent an OTP to your registered email address',
                      maxLines: 2,
                      style: font16w400,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    OtpInputField(
                      onChanged: (value) {
                        _otp = value;
                      },
                      onCompleted: (value) {
                        _otp = value;
                      },
                    ),
                    SizedBox(height: 10.h),
                    AppText(
                      "00:${seconds.toString().padLeft(2, '0')}",
                      style: font16w400.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFFFAFAFA)
                            : const Color(0xFF7B92BA),
                      ),
                      alignment: AlignmentDirectional.center,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          "Didn’t get a code?  ",
                          style: font16w400,
                        ),
                        GestureDetector(
                          onTap: seconds == 0 && !state.isLoading
                              ? () {
                                  if (widget.flow ==
                                      CheckMailFlow.emailVerification) {
                                    context.read<AuthCubit>().resendOtp(
                                          email: widget.email,
                                        );
                                  } else {
                                    context
                                        .read<AuthCubit>()
                                        .forgotPasswordResendOtp(
                                          email: widget.email,
                                        );
                                  }

                                  startTimer();
                                }
                              : null,
                          child: AppText(
                            "Resend",
                            style: font16w700.copyWith(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? (seconds == 0
                                      ? const Color(0xFFFAFAFA)
                                      : const Color.fromARGB(
                                          255, 121, 122, 122))
                                  : (seconds == 0
                                      ? const Color(0xFF000000)
                                      : const Color.fromARGB(
                                          255,
                                          211,
                                          212,
                                          214,
                                        )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    AppButton(
                      text: state.isLoading ? 'Loading...' : 'Continue',
                      color: isDarkMode ? Colors.white : Colors.black,
                      textColor: isDarkMode ? Colors.black : Colors.white,
                      onPressed: state.isLoading
                          ? null
                          : () {
                              if (_otp.length != 4) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter 4-digit OTP.'),
                                  ),
                                );
                                return;
                              }

                              if (widget.flow ==
                                  CheckMailFlow.emailVerification) {
                                context.read<AuthCubit>().verifyOtp(
                                      email: widget.email,
                                      otp: _otp,
                                    );
                              } else {
                                context.read<AuthCubit>().forgotPasswordVerify(
                                      email: widget.email,
                                      otp: _otp,
                                    );
                              }
                            },
                      height: 50.h,
                      radius: 22.r,
                    ),
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
