import 'package:flutter/material.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/presentation/cubit/practice_cubit.dart';

import 'practice_levels_home.dart';
import 'practice_level_page.dart';

class PracticeScreenBody extends StatelessWidget {
  final int? selectedLevelIndex;
  final PracticeState state;
  final VoidCallback onGoBackOneStep;
  final void Function(int) onSelect;

  const PracticeScreenBody({
    super.key,
    required this.selectedLevelIndex,
    required this.state,
    required this.onGoBackOneStep,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        AppAsset(
          assetName: themeController.themeMode == ThemeMode.dark
              ? Assets.splashdark
              : Assets.splashlight,
        ),
        SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: selectedLevelIndex != null
                ? PracticeLevelPage(
                    state: state,
                    index: selectedLevelIndex!,
                    onGoBackOneStep: onGoBackOneStep,
                  )
                : PracticeLevelsHome(
                    state: state,
                    onSelect: onSelect,
                  ),
          ),
        ),
      ],
    );
  }
}
