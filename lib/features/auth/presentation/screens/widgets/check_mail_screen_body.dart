import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';

import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/otp_input_field.dart';

class CheckMailScreenBody extends StatefulWidget {
  const CheckMailScreenBody({super.key});

  @override
  State<CheckMailScreenBody> createState() => _CheckMailScreenBodyState();
}

class _CheckMailScreenBodyState extends State<CheckMailScreenBody> {
  int seconds = 60;
  Timer? _timer;

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 72.h,
            ),
            const AppAsset(assetName: Assets.emailcheck),
            AppText(
              'Check your mail',
              style: font20w700,
              alignment: AlignmentDirectional.center,
            ),
            SizedBox(height: 4.h),
            AppText(
              'We just sent an OTP to your registered email address',
              maxLines: 2,
              style: font16w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            const OtpInputField(),
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
                  onTap: seconds == 0 ? startTimer : null,
                  child: AppText(
                    "Resend",
                    style: font16w700.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? (seconds == 0
                              ? const Color(0xFFFAFAFA)
                              : const Color.fromARGB(255, 121, 122, 122))
                          : (seconds == 0
                              ? const Color(0xFF000000)
                              : const Color.fromARGB(255, 211, 212, 214)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            AppButton(
              text: 'Continue',
              onPressed: () {
                GoRouter.of(context).push(Routes.createNewPasswordScreen);
              },
              height: 50.h,
              radius: 22.r,
            ),
          ],
        ),
      ),
    );
  }
}
