import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/theme_toggle_switch.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_profile_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/info_profile.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/item_profile_options.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final bool isDark = themeController.themeMode == ThemeMode.dark;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppAsset(
              assetName: isDark ? Assets.splashdark : Assets.splashlight,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const CustomAppBarRow(title: '  My Profile'),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: InfoProfile(themeMode: themeController.themeMode),
                  ),

                  SizedBox(height: 24.h),
                  CustomProfileCard(themeMode: themeController.themeMode),
                  SizedBox(height: 16.h),

                  /// Container Options Section
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 13.w),
                    decoration: BoxDecoration(
                      color: const Color(0xffFAFAFA),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Options',
                            style: font16w700.copyWith(color: Colors.black),
                          ),

                          SizedBox(height: 16.h),

                          /// Theme Change Row
                          Row(
                            children: [
                              ItemProfileOptions(
                                image: Assets.iconTheme,
                                title: 'Change Theme',
                              ),
                              const Spacer(),
                              ThemeToggleSwitch(
                                isDarkMode: isDark,
                                activeColor:
                                    isDark ? Colors.white : Colors.black,
                                onChanged: (_) {
                                  ThemeController.of(context).toggleTheme();
                                },
                              ),
                            ],
                          ),

                          SizedBox(height: 14.h),

                          ItemProfileOptions(
                            image: Assets.iconRemove,
                            title: 'Clear My progress',
                          ),

                          SizedBox(height: 14.h),

                          ItemProfileOptions(
                            image: Assets.iconLogout,
                            title: 'Logout',
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  AppAsset(
                    width: 175.w,
                    height: 55.h,
                    assetName:
                        isDark ? Assets.darkappbarlogo : Assets.lightappbarlogo,
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
