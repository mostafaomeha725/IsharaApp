import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/features/home/presentation/screens/home_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/learn_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/nav_bar_item.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/practice_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/profile_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_screen.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});
  static _CustomNavBarState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CustomNavBarState>();

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  final List<int> _navigationStack = [0]; // عشان اخزن تاريخ اخر صفحه وصلتلهتا

  final List<Widget> _screens = [
    const HomeScreen(),
    const LearnScreen(),
    const PracticeScreen(),
    const TestScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
      _navigationStack.add(index);
    });
  }

  Future<bool> onWillPop() async {
    if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast();
        _selectedIndex = _navigationStack.last;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _screens[_selectedIndex],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 65.h,
          color: gender == GenderTheme.boy
              ? const Color(0xFF152D57)
              : const Color(0xFF571B42),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                icon: Assets.homeIcon,
                isSelected: _selectedIndex == 0,
                gender: gender,
                onTap: () => _onItemTapped(0),
              ),
              NavBarItem(
                icon: Assets.youtubeIcon,
                isSelected: _selectedIndex == 1,
                gender: gender,
                onTap: () => _onItemTapped(1),
              ),
              NavBarItem(
                icon: Assets.bookIcon,
                isSelected: _selectedIndex == 2,
                gender: gender,
                onTap: () => _onItemTapped(2),
              ),
              NavBarItem(
                icon: Assets.aiIcon,
                isSelected: _selectedIndex == 3,
                gender: gender,
                onTap: () => _onItemTapped(3),
              ),
              NavBarItem(
                icon: Assets.profileIcon,
                isSelected: _selectedIndex == 4,
                gender: gender,
                onTap: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
