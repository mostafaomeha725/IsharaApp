import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/core/di/practice_di.dart';
import 'package:isharaapp/features/home/domain/entities/practice/practice_level_entity.dart';
import 'package:isharaapp/features/home/presentation/cubit/practice_cubit.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_four_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_one_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_three_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_two_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_nav_bar.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  int? _selectedLevelIndex;
  late final PracticeCubit _practiceCubit;

  static const List<String> _levelCardAssets = <String>[
    Assets.catonbooks,
    Assets.boylookingglobal,
    Assets.booksandcup,
    Assets.stackofbooks,
  ];

  @override
  void initState() {
    super.initState();
    _practiceCubit = PracticeDi.createCubit()..loadLevels();
  }

  @override
  void dispose() {
    _practiceCubit.close();
    super.dispose();
  }

  void _goBackOneStep() {
    setState(() {
      if (_selectedLevelIndex != null) {
        _selectedLevelIndex = null;
      } else {
        final navBarState = CustomNavBar.of(context);
        navBarState?.onWillPop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _practiceCubit,
      child: BlocConsumer<PracticeCubit, PracticeState>(
        listener: (context, state) {
          if (state.message == null || state.message!.isEmpty) {
            return;
          }

          if (state.status == PracticeStatus.error ||
              state.action == PracticeAction.completeLesson) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          final themeController = ThemeController.of(context);
          final levels = state.levels;

          final appBarTitle = _selectedLevelIndex == null
              ? 'Practice'
              : (levels.length > _selectedLevelIndex!
                  ? (levels[_selectedLevelIndex!].title.isEmpty
                      ? 'Level ${_selectedLevelIndex! + 1}'
                      : levels[_selectedLevelIndex!].title)
                  : 'Practice');

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: HomeAppbar(title: appBarTitle, onBack: _goBackOneStep),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
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
                    child: _selectedLevelIndex != null
                        ? _buildLevelScreen(
                            context: context,
                            state: state,
                            index: _selectedLevelIndex!,
                          )
                        : _buildLevelsHome(context, state),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLevelScreen({
    required BuildContext context,
    required PracticeState state,
    required int index,
  }) {
    final levels = state.levels;
    final level = index < levels.length ? levels[index] : null;

    final items =
        level?.lessons.map((item) => _normalizeLabel(item.title)).toList();
    final idsByItem = level == null
        ? const <String, int>{}
        : {
            for (final lesson in level.lessons)
              _normalizeLabel(lesson.title): lesson.id,
          };
    final completedItems = level == null
        ? const <String>{}
        : {
            for (final lesson in level.lessons)
              if (lesson.isCompleted) _normalizeLabel(lesson.title),
          };

    Future<void> onComplete(int lessonId) {
      return context.read<PracticeCubit>().completeLesson(lessonId);
    }

    switch (index) {
      case 0:
        return LearnLevelOneScreen(
          key: const ValueKey('practiceLevelOne'),
          ispractise: true,
          onBack: _goBackOneStep,
          items: items,
          lessonIdsByItem: idsByItem,
          completedItems: completedItems,
          completionType: 'practice',
          onCompleteLesson: onComplete,
        );
      case 1:
        return LearnLevelTwoScreen(
          key: const ValueKey('practiceLevelTwo'),
          ispractise: true,
          onBack: _goBackOneStep,
          items: items,
          lessonIdsByItem: idsByItem,
          completedItems: completedItems,
          completionType: 'practice',
          onCompleteLesson: onComplete,
        );
      case 2:
        return LearnLevelThreeScreen(
          key: const ValueKey('practiceLevelThree'),
          ispractise: true,
          onBack: _goBackOneStep,
          items: items,
          lessonIdsByItem: idsByItem,
          completedItems: completedItems,
          completionType: 'practice',
          onCompleteLesson: onComplete,
        );
      case 3:
        return LearnLevelFourScreen(
          key: const ValueKey('practiceLevelFour'),
          ispractise: true,
          onBack: _goBackOneStep,
          items: items,
          lessonIdsByItem: idsByItem,
          completedItems: completedItems,
          completionType: 'practice',
          onCompleteLesson: onComplete,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLevelsHome(BuildContext context, PracticeState state) {
    final levels = state.levels;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppAsset(
                assetName: Assets.youngwomanwritingnotebook,
                width: 100.w,
              ),
              SizedBox(width: 16.w),
              Column(
                children: [
                  AppText(
                    'Use your camera to',
                    style: font16w700,
                    alignment: AlignmentDirectional.center,
                  ),
                  AppText(
                    'practice signs.',
                    style: font16w700,
                    alignment: AlignmentDirectional.center,
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              AppAsset(
                assetName:
                    Assets.sideviewofyoungmanwearingsmartwatchandholdingbook,
                width: 80.w,
              ),
            ],
          ),
          SizedBox(height: 38.h),
          if (state.status == PracticeStatus.loading && levels.isEmpty)
            const Center(child: CircularProgressIndicator())
          else if (levels.isEmpty)
            _buildFallbackCards()
          else
            ..._buildApiCards(levels),
          if (state.status == PracticeStatus.error)
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: TextButton.icon(
                onPressed: () {
                  context.read<PracticeCubit>().loadLevels(forceLoading: true);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry loading levels'),
              ),
            ),
          SizedBox(height: 38.h),
        ],
      ),
    );
  }

  List<Widget> _buildApiCards(List<PracticeLevelEntity> levels) {
    final widgets = <Widget>[];
    final maxCards = levels.length > 4 ? 4 : levels.length;

    for (var i = 0; i < maxCards; i++) {
      final level = levels[i];
      final labels =
          level.lessons.map((lesson) => _normalizeLabel(lesson.title));

      widgets.add(
        CourseCard(
          title: level.title.isEmpty ? 'Level ${i + 1}' : level.title,
          subtitle: level.subtitle.isNotEmpty
              ? level.subtitle
              : 'letters ${labels.join(' ')}',
          completetext:
              '${level.completedLessons} of ${level.totalLessons} completed',
          value: level.progress.clamp(0, 1).toDouble(),
          isPractice: true,
          showBadgeImage: true,
          assetName: _levelCardAssets[i],
          onTap: () {
            setState(() {
              _selectedLevelIndex = i;
            });
          },
        ),
      );

      if (i != maxCards - 1) {
        widgets.add(SizedBox(height: 38.h));
      }
    }

    return widgets;
  }

  Widget _buildFallbackCards() {
    return Column(
      children: [
        CourseCard(
          title: 'Level One',
          subtitle: 'letters A B C E L O V W U Y',
          completetext: '0 of 10 completed',
          value: 0.0,
          isPractice: true,
          assetName: Assets.catonbooks,
          showBadgeImage: true,
          onTap: () {
            setState(() {
              _selectedLevelIndex = 0;
            });
          },
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Two',
          subtitle: 'letters D F K R S I T',
          completetext: '0 of 7 completed',
          value: 0.0,
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.boylookingglobal,
          onTap: () {
            setState(() {
              _selectedLevelIndex = 1;
            });
          },
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Three',
          subtitle: 'letters G H M N X',
          completetext: '0 of 5 completed',
          value: 0.0,
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.booksandcup,
          onTap: () {
            setState(() {
              _selectedLevelIndex = 2;
            });
          },
        ),
        SizedBox(height: 38.h),
        CourseCard(
          title: 'Level Four',
          subtitle: 'letters P Q Z J',
          completetext: '0 of 4 completed',
          value: 0.0,
          isPractice: true,
          showBadgeImage: true,
          assetName: Assets.stackofbooks,
          onTap: () {
            setState(() {
              _selectedLevelIndex = 3;
            });
          },
        ),
      ],
    );
  }

  String _normalizeLabel(String raw) {
    final value = raw.trim();
    if (value.isEmpty) {
      return '-';
    }
    return value.split(RegExp(r'\s+')).last.toUpperCase();
  }
}
