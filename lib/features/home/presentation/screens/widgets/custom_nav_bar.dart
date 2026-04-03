import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/storage/app_session_manager.dart';
import 'package:isharaapp/features/home/presentation/screens/home_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/learn_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/nav_bar_item.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/practice_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/profile_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_screen.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});
  static CustomNavBarState? of(BuildContext context) =>
      context.findAncestorStateOfType<CustomNavBarState>();

  @override
  State<CustomNavBar> createState() => CustomNavBarState();
}

class CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  final List<int> _navigationStack = [0];
  final List<Widget> _screens = [];
  final AppSessionManager _sessionManager = AppSessionManager();

  Future<void> _guardAuthToken() async {
    final hasAuthToken = await _sessionManager.hasAuthToken();
    if (!mounted || hasAuthToken) {
      return;
    }

    GoRouter.of(context).go(Routes.loginScreen);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _guardAuthToken();
    });

    _screens.addAll([
      HomeScreen(
        onNavigateToTab: (index) {
          _onItemTapped(index);
        },
      ),
      const LearnScreen(),
      const PracticeScreen(),
      const TestScreen(),
      const ProfileScreen(),
    ]);
  }

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
    return PopScope(
      canPop: _navigationStack.length <= 1,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        await onWillPop();
      },
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _screens[_selectedIndex],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 65.h,
          color: const Color(0xff252525),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                icon: Assets.homeIcon,
                isSelected: _selectedIndex == 0,
                onTap: () => _onItemTapped(0),
              ),
              NavBarItem(
                icon: Assets.youtubeIcon,
                isSelected: _selectedIndex == 1,
                onTap: () => _onItemTapped(1),
              ),
              NavBarItem(
                icon: Assets.bookIcon,
                isSelected: _selectedIndex == 2,
                onTap: () => _onItemTapped(2),
              ),
              NavBarItem(
                icon: Assets.aiIcon,
                isSelected: _selectedIndex == 3,
                onTap: () => _onItemTapped(3),
              ),
              NavBarItem(
                icon: Assets.profileIcon,
                isSelected: _selectedIndex == 4,
                onTap: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
