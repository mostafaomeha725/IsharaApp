import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_runtime_helpers.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_screen_level_data.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_screen_levels_home.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_screen_selected_level.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int? _selectedLevel;

  TestScreenLevelData? get _selectedLevelData {
    if (_selectedLevel == null) return null;

    for (final level in testScreenLevels) {
      if (level.id == _selectedLevel) {
        return level;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Warm model in background while user picks a level/word.
      unawaited(prewarmTestLevelModel());
    });
  }

  void _openLevel(int level) {
    setState(() {
      _selectedLevel = level;
    });
  }

  void _closeLevel() {
    setState(() {
      _selectedLevel = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final selectedLevel = _selectedLevelData;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AppAsset(
              assetName: themeController.themeMode == ThemeMode.dark
                  ? Assets.splashdark
                  : Assets.splashlight,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedLevel != null
                  ? buildTestSelectedLevel(
                      level: selectedLevel,
                      onBack: _closeLevel,
                    )
                  : TestScreenLevelsHome(
                      themeController: themeController,
                      onOpenLevel: _openLevel,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
