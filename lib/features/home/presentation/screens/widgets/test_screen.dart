import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/di/test_di.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/domain/entities/test/test_level_entity.dart';
import 'package:isharaapp/features/home/presentation/cubit/test_api_cubit.dart';
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
  late final TestApiCubit _testApiCubit;

  static const List<Alignment> _levelAlignments = <Alignment>[
    Alignment(-0.88, -0.88),
    Alignment(0.88, -0.62),
    Alignment(-0.88, -0.32),
    Alignment(0.88, 0.06),
  ];

  static const List<String> _levelAssets = <String>[
    Assets.book1,
    Assets.book2,
    Assets.book3,
    Assets.book4,
  ];

  static const List<String> _fallbackLevelOneWords = <String>[
    'able',
    'love',
    'buy',
    'cube',
  ];
  static const List<String> _fallbackLevelTwoWords = <String>[
    'risk',
    'sir',
    'dirt',
    'kids',
  ];
  static const List<String> _fallbackLevelThreeWords = <String>[
    'foxy',
    'onyx',
    'gown',
    'honk',
  ];
  static const List<String> _fallbackLevelFourWords = <String>[
    'quiz',
    'mazy',
    'jive',
    'vape',
  ];

  TestScreenLevelData? _selectedLevelData(List<TestScreenLevelData> levels) {
    if (_selectedLevel == null) {
      return null;
    }

    for (final level in levels) {
      if (level.id == _selectedLevel) {
        return level;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _testApiCubit = TestDi.createCubit()..loadLevels();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(prewarmTestLevelModel());
    });
  }

  @override
  void dispose() {
    _testApiCubit.close();
    super.dispose();
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
    return BlocProvider.value(
      value: _testApiCubit,
      child: BlocConsumer<TestApiCubit, TestApiState>(
        listener: (context, state) {
          if (state.message == null || state.message!.isEmpty) {
            return;
          }

          if (state.status == TestApiStatus.error ||
              state.action == TestApiAction.completeWord) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          final themeController = ThemeController.of(context);
          final levels = _mapLevels(state.levels);
          final selectedLevel = _selectedLevelData(levels);

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
                            onCompleteWord: (wordId) {
                              return context
                                  .read<TestApiCubit>()
                                  .completeWord(wordId);
                            },
                          )
                        : TestScreenLevelsHome(
                            themeController: themeController,
                            levels: levels,
                            onOpenLevel: _openLevel,
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

  List<TestScreenLevelData> _mapLevels(List<TestLevelEntity> levels) {
    if (levels.isEmpty) {
      return _fallbackLevels();
    }

    final result = <TestScreenLevelData>[];
    final maxLevels = levels.length > 4 ? 4 : levels.length;

    for (var i = 0; i < maxLevels; i++) {
      final level = levels[i];

      final words =
          level.words.map((item) => _normalizeWordLabel(item.word)).toList();

      final wordIds = <String, int>{};
      final completedItems = <String>{};
      for (final word in level.words) {
        final normalized = _normalizeWordLabel(word.word);
        wordIds[normalized] = word.id;
        if (word.isCompleted) {
          completedItems.add(normalized);
        }
      }

      result.add(
        TestScreenLevelData(
          id: level.id,
          label: level.title.isEmpty ? 'Level ${i + 1}' : level.title,
          assetName: _levelAssets[i],
          words: words,
          wordIds: wordIds,
          completedItems: completedItems,
          completedWords: level.completedWords,
          alignment: _levelAlignments[i],
          keyName: 'testApiLevel${level.id}',
        ),
      );
    }

    return result;
  }

  List<TestScreenLevelData> _fallbackLevels() {
    final data = <List<String>>[
      _fallbackLevelOneWords,
      _fallbackLevelTwoWords,
      _fallbackLevelThreeWords,
      _fallbackLevelFourWords,
    ];

    return List<TestScreenLevelData>.generate(4, (index) {
      final words = data[index];
      return TestScreenLevelData(
        id: index + 1,
        label: 'Level ${index + 1}',
        assetName: _levelAssets[index],
        words: words,
        wordIds: const <String, int>{},
        completedItems: const <String>{},
        completedWords: 0,
        alignment: _levelAlignments[index],
        keyName: 'testFallbackLevel${index + 1}',
      );
    });
  }

  String _normalizeWordLabel(String value) {
    final text = value.trim();
    if (text.isEmpty) {
      return '-';
    }
    return text.toLowerCase();
  }
}
