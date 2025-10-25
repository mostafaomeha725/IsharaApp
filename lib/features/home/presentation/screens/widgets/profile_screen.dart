import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/theme_toggle_switch.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_profile_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/info_profile.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/item_profile_options.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
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
            Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Spacer(),
                      Text(
                        '    My Profile',
                        style: font20w700,
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: InfoProfile(gender: gender),
                ),
                SizedBox(height: 20.h),
                CustomProfileCard(gender: gender),
                SizedBox(height: 20.h),
                Container(
                  width: 398.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Options',
                          style: font16w700.copyWith(
                            color: gender == GenderTheme.boy
                                ? const Color(0xFF3A7CF2)
                                : const Color(0xFFF24BB6),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            ItemProfileOptions(
                              image: gender == GenderTheme.boy
                                  ? Assets.themeBoy
                                  : Assets.themeGirl,
                              title: 'Change Theme',
                            ),
                            const Spacer(),
                            ThemeToggleSwitch(
                              isDarkMode: gender == GenderTheme.boy,
                              activeColor: gender == GenderTheme.boy
                                  ? const Color(0xFF3A7CF2)
                                  : const Color(0xFFF24BB6),
                              onChanged: (_) {
                                final controller = GenderController.of(context);
                                controller.onGenderChanged(
                                  gender == GenderTheme.boy
                                      ? GenderTheme.girl
                                      : GenderTheme.boy,
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        ItemProfileOptions(
                          image: gender == GenderTheme.boy
                              ? Assets.cleardBoy
                              : Assets.clearGirl,
                          title: 'Clear My progress',
                        ),
                        SizedBox(height: 14.h),
                        ItemProfileOptions(
                          image: gender == GenderTheme.boy
                              ? Assets.logoutBoy
                              : Assets.logoutGirl,
                          title: 'Logout',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
