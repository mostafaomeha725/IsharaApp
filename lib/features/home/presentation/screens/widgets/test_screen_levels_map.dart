import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/dotted_path_painter.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/level_bubble.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_screen_level_data.dart';

class TestScreenLevelsMap extends StatelessWidget {
  const TestScreenLevelsMap({
    super.key,
    required this.themeMode,
    required this.levels,
    required this.onOpenLevel,
  });

  final ThemeMode themeMode;
  final List<TestScreenLevelData> levels;
  final ValueChanged<int> onOpenLevel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: DottedPathPainter(themeMode: themeMode),
            ),
          ),
          ...levels.map((level) {
            return Align(
              alignment: level.alignment,
              child: LevelBubble(
                assetName: level.assetName,
                label: level.label,
                onTap: () => onOpenLevel(level.id),
              ),
            );
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: const AppAsset(assetName: Assets.passImage),
            ),
          ),
        ],
      ),
    );
  }
}
