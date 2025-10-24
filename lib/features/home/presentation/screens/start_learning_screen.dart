import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/start_learning_screen_body.dart';

class StartLearningScreen extends StatelessWidget {
  const StartLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;

    final bgColor = gender == GenderTheme.boy
        ? const Color(0xFF3A7CF2)
        : const Color(0xFFF24BB6);

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            image: const DecorationImage(
              image: AssetImage(Assets.girlsplash),
              fit: BoxFit.cover,
              opacity: 0.70,
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: StartLearningScreenBody(
              onGoBack: () {},
            ),
          ),
        ),
      ],
    );
  }
}
