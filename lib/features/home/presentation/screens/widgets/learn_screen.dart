import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/domain/entities/learn_level_entity.dart';
import 'package:isharaapp/features/home/presentation/cubit/learn_cubit.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_four_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_one_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_three_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_two_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/start_learning_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';
import 'package:isharaapp/core/di/learn_di.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  int _currentIndex = 0;
  late final LearnCubit _learnCubit;

  static const List<String> _levelCardAssets = <String>[
    Assets.catonbooks,
    Assets.boylookingglobal,
    Assets.booksandcup,
    Assets.stackofbooks,
  ];

  @override
  void initState() {
    super.initState();
    _learnCubit = LearnDi.createCubit()..loadLevels();
  }

  @override
  void dispose() {
    _learnCubit.close();
    super.dispose();
  }

  void _goTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _goBack() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _learnCubit,
      child: BlocConsumer<LearnCubit, LearnState>(
        listener: (context, state) {
          final message = state.message;
          if (message == null || message.isEmpty) {
            return;
          }

          if (state.status == LearnStatus.error ||
              state.action == LearnAction.completeLesson) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        },
        builder: (context, state) {
          final themeController = ThemeController.of(context);
          final pages = _buildPages(context, state);
          final pageIndex = _currentIndex >= pages.length ? 0 : _currentIndex;

          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(
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
                    child: pages[pageIndex],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildPages(BuildContext context, LearnState state) {
    final levels = state.levels;

    return [
      _buildMainMenu(context, state),
      StartLearningScreen(onGoBack: _goBack, onPressed: () => _goTo(2)),
      _buildLevelPage(
        blocContext: context,
        level: levels.isNotEmpty ? levels[0] : null,
        index: 0,
        completingLessonId: state.completingLessonId,
      ),
      _buildLevelPage(
        blocContext: context,
        level: levels.length > 1 ? levels[1] : null,
        index: 1,
        completingLessonId: state.completingLessonId,
      ),
      _buildLevelPage(
        blocContext: context,
        level: levels.length > 2 ? levels[2] : null,
        index: 2,
        completingLessonId: state.completingLessonId,
      ),
      _buildLevelPage(
        blocContext: context,
        level: levels.length > 3 ? levels[3] : null,
        index: 3,
        completingLessonId: state.completingLessonId,
      ),
    ];
  }

  Widget _buildLevelPage({
    required BuildContext blocContext,
    required LearnLevelEntity? level,
    required int index,
    required int? completingLessonId,
  }) {
    final items = level == null ? null : _buildLessonItems(level);
    final lessonIdsByItem =
        level == null ? const <String, int>{} : _buildLessonIdMap(level);
    final completedItems =
        level == null ? const <String>{} : _buildCompletedItems(level);

    final Future<void> Function(int lessonId)? onCompleteLesson = level == null
        ? null
        : (lessonId) {
            return blocContext.read<LearnCubit>().completeLesson(lessonId);
          };

    switch (index) {
      case 0:
        return LearnLevelOneScreen(
          ispractise: false,
          onBack: _goBack,
          items: items,
          lessonIdsByItem: lessonIdsByItem,
          completedItems: completedItems,
          completingLessonId: completingLessonId,
          onCompleteLesson: onCompleteLesson,
        );
      case 1:
        return LearnLevelTwoScreen(
          ispractise: false,
          onBack: _goBack,
          items: items,
          lessonIdsByItem: lessonIdsByItem,
          completedItems: completedItems,
          completingLessonId: completingLessonId,
          onCompleteLesson: onCompleteLesson,
        );
      case 2:
        return LearnLevelThreeScreen(
          ispractise: false,
          onBack: _goBack,
          items: items,
          lessonIdsByItem: lessonIdsByItem,
          completedItems: completedItems,
          completingLessonId: completingLessonId,
          onCompleteLesson: onCompleteLesson,
        );
      case 3:
        return LearnLevelFourScreen(
          ispractise: false,
          onBack: _goBack,
          items: items,
          lessonIdsByItem: lessonIdsByItem,
          completedItems: completedItems,
          completingLessonId: completingLessonId,
          onCompleteLesson: onCompleteLesson,
        );
      default:
        return LearnLevelOneScreen(ispractise: false, onBack: _goBack);
    }
  }

  Widget _buildMainMenu(BuildContext context, LearnState state) {
    final levels = state.levels;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 76.h),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child:
                        AppAsset(assetName: Assets.boyandgirlworkoncomputer)),
                SizedBox(height: 32.h),
                if (state.status == LearnStatus.loading && levels.isEmpty)
                  const Center(child: CircularProgressIndicator())
                else
                  ..._buildLevelCards(levels),
                if (state.status == LearnStatus.error)
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: TextButton.icon(
                      onPressed: () {
                        context
                            .read<LearnCubit>()
                            .loadLevels(forceLoading: true);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry loading levels'),
                    ),
                  ),
                SizedBox(height: 36.h),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: HomeAppbar(title: 'Learn'),
        ),
      ],
    );
  }

  List<Widget> _buildLevelCards(List<LearnLevelEntity> levels) {
    if (levels.isEmpty) {
      return [
        CourseCard(
          title: 'Level One',
          assetName: Assets.catonbooks,
          subtitle: 'letters A B C E L O V W U Y',
          completetext: '0 of 10 completed',
          value: 0.0,
          onTap: () => _goTo(2),
          isPractice: true,
          showBadgeImage: true,
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Two',
          subtitle: 'letters D F K R S I T',
          completetext: '0 of 7 completed',
          value: 0.0,
          onTap: () => _goTo(3),
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.boylookingglobal,
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Three',
          subtitle: 'letters G H M N X',
          completetext: '0 of 5 completed',
          value: 0.0,
          onTap: () => _goTo(4),
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.booksandcup,
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Four',
          subtitle: 'letters P Q Z J',
          completetext: '0 of 4 completed',
          value: 0.0,
          onTap: () => _goTo(5),
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.stackofbooks,
        ),
      ];
    }

    final cards = <Widget>[];
    final maxCards = levels.length > 4 ? 4 : levels.length;

    for (var i = 0; i < maxCards; i++) {
      final level = levels[i];
      final subtitle = level.subtitle.isNotEmpty
          ? level.subtitle
          : 'letters ${_buildLessonItems(level).join(' ')}';

      cards.add(
        CourseCard(
          title: level.title.isEmpty ? 'Level ${i + 1}' : level.title,
          subtitle: subtitle,
          completetext:
              '${level.completedLessons} of ${level.totalLessons} completed',
          value: level.progress.clamp(0, 1).toDouble(),
          onTap: () => _goTo(i + 2),
          isPractice: true,
          showBadgeImage: true,
          assetName: _levelCardAssets[i],
        ),
      );

      if (i != maxCards - 1) {
        cards.add(SizedBox(height: 38.h));
      }
    }

    return cards;
  }

  List<String> _buildLessonItems(LearnLevelEntity level) {
    return level.lessons
        .asMap()
        .entries
        .map((entry) => _lessonItemLabel(entry.value.title, entry.key))
        .toList();
  }

  Map<String, int> _buildLessonIdMap(LearnLevelEntity level) {
    final result = <String, int>{};
    for (var i = 0; i < level.lessons.length; i++) {
      final lesson = level.lessons[i];
      result[_lessonItemLabel(lesson.title, i)] = lesson.id;
    }
    return result;
  }

  Set<String> _buildCompletedItems(LearnLevelEntity level) {
    final result = <String>{};
    for (var i = 0; i < level.lessons.length; i++) {
      final lesson = level.lessons[i];
      if (lesson.isCompleted) {
        result.add(_lessonItemLabel(lesson.title, i));
      }
    }
    return result;
  }

  String _lessonItemLabel(String raw, int index) {
    final value = raw.trim();
    if (value.isEmpty) {
      return 'L${index + 1}';
    }

    final parts = value.split(RegExp(r'\s+'));
    return parts.last.toUpperCase();
  }
}
