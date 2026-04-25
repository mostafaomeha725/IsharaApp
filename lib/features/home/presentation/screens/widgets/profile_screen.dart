import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/auth/presentation/screens/widgets/theme_toggle_switch.dart';
import 'package:isharaapp/features/home/domain/entities/profile_user_entity.dart';
import 'package:isharaapp/features/home/presentation/cubit/profile_cubit.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_profile_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/info_profile.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/item_profile_options.dart';
import 'package:isharaapp/core/di/profile_di.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _showEditNameDialog(
    BuildContext context,
    ProfileState state,
  ) async {
    final user = state.user;
    if (user == null) return;

    final firstNameController = TextEditingController(text: user.firstName);
    final lastNameController = TextEditingController(text: user.lastName);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final firstName = firstNameController.text.trim();
                final lastName = lastNameController.text.trim();

                if (firstName.isEmpty || lastName.isEmpty) {
                  return;
                }

                context.read<ProfileCubit>().updateName(
                      firstName: firstName,
                      lastName: lastName,
                    );
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileDi.createCubit()..loadProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.error && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }

          if (state.status == ProfileStatus.success && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }

          if (state.status == ProfileStatus.success &&
              state.action == ProfileAction.logout) {
            GoRouter.of(context).go(Routes.loginScreen);
          }
        },
        builder: (context, state) {
          final themeController = ThemeController.of(context);
          final bool isDark = themeController.themeMode == ThemeMode.dark;
          final user = state.user;
          final displayUser = user ??
              const ProfileUserEntity(
                id: 0,
                firstName: '',
                lastName: '',
                fullName: 'User',
                email: '-',
                gender: '-',
                dateOfBirth: '-',
                isVerified: false,
              );

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
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: InfoProfile(
                            themeMode: themeController.themeMode,
                            fullName: displayUser.fullName,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomProfileCard(
                          user: displayUser,
                          isLoading: state.isLoading &&
                              state.action == ProfileAction.updateName,
                          onEditName: () => _showEditNameDialog(
                            context,
                            state,
                          ),
                        ),
                        if (state.status == ProfileStatus.loading &&
                            state.action == ProfileAction.loadProfile) ...[
                          SizedBox(height: 12.h),
                          const CircularProgressIndicator(),
                        ],
                        if (state.status == ProfileStatus.error && user == null)
                          Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: TextButton.icon(
                              onPressed: () {
                                context.read<ProfileCubit>().loadProfile();
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry loading profile'),
                            ),
                          ),
                        SizedBox(height: 16.h),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xffFAFAFA),
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Options',
                                  style:
                                      font16w700.copyWith(color: Colors.black),
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  children: [
                                    const ItemProfileOptions(
                                      image: Assets.iconTheme,
                                      title: 'Change Theme',
                                    ),
                                    const Spacer(),
                                    ThemeToggleSwitch(
                                      isDarkMode: isDark,
                                      activeColor:
                                          isDark ? Colors.white : Colors.black,
                                      onChanged: (_) {
                                        ThemeController.of(context)
                                            .toggleTheme();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14.h),
                                ItemProfileOptions(
                                  image: Assets.iconRemove,
                                  title: 'Clear My progress',
                                  onTap: state.isLoading
                                      ? null
                                      : () {
                                          context
                                              .read<ProfileCubit>()
                                              .clearProgress();
                                        },
                                ),
                                SizedBox(height: 14.h),
                                ItemProfileOptions(
                                  image: Assets.iconLogout,
                                  title: state.isLoading &&
                                          state.action == ProfileAction.logout
                                      ? 'Logging out...'
                                      : 'Logout',
                                  onTap: state.isLoading
                                      ? null
                                      : () {
                                          context.read<ProfileCubit>().logout();
                                        },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        AppAsset(
                          width: 175.w,
                          height: 55.h,
                          assetName: isDark
                              ? Assets.darkappbarlogo
                              : Assets.lightappbarlogo,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
