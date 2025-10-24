import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;

    return Scaffold(
      backgroundColor: gender == GenderTheme.boy
          ? const Color(0xFF3A7CF2)
          : const Color(0xFFF24BB6),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppAsset(
              assetName: gender == GenderTheme.boy
                  ? Assets.boySplash
                  : Assets.girlsplash,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Night, Mahmoud Elhenawy',
                              style: font20w700.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Welcome to Ishara',
                              style: font16w400.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        AppAsset(
                          assetName: Assets.homeprofile,
                          width: 35.w,
                          height: 35.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    HomeCard(
                      title: "Learn",
                      subtitle: 'Explore new lessons and expand your knowledge',
                      image: gender == GenderTheme.boy
                          ? Assets.learnBoy
                          : Assets.learngirl,
                      backgroundColor: gender == GenderTheme.boy
                          ? const Color(0xFFECF2FE)
                          : const Color(0xffFEF1F9),
                      onArrowTap: () {},
                    ),
                    SizedBox(height: 14.h),
                    HomeCard(
                      title: "Practice",
                      subtitle:
                          'Reinforce what you have learned with Quick exercises',
                      image: gender == GenderTheme.boy
                          ? Assets.practieboy
                          : Assets.practiegirl,
                      backgroundColor: gender == GenderTheme.boy
                          ? const Color(0xFFECF2FE)
                          : const Color(0xffFEF1F9),
                      onArrowTap: () {},
                    ),
                    SizedBox(height: 14.h),
                    HomeCard(
                      title: "Test yourself with AI Bot",
                      subtitle: 'Explore new lessons and expand your knowledge',
                      image: gender == GenderTheme.boy
                          ? Assets.testboy
                          : Assets.testgirl,
                      backgroundColor: gender == GenderTheme.boy
                          ? const Color(0xFFECF2FE)
                          : const Color(0xffFEF1F9),
                      onArrowTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
