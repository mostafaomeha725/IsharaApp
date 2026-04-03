import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/lesseon_details_screen.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_runtime_helpers.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/learn_level_shared_flow_mixin.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/course_card.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';

class LearnLevelFourScreen extends StatefulWidget {
  const LearnLevelFourScreen({
    super.key,
    required this.ispractise,
    this.onBack,
    this.items,
    this.lessonIdsByItem = const <String, int>{},
    this.completedItems = const <String>{},
    this.completingLessonId,
    this.onCompleteLesson,
    this.completionType,
    this.itemType = 'Letter',
    this.headerTitle = 'letters',
    this.headerSubtitle,
  });

  final bool ispractise;
  final VoidCallback? onBack;
  final List<String>? items;
  final Map<String, int> lessonIdsByItem;
  final Set<String> completedItems;
  final int? completingLessonId;
  final Future<void> Function(int lessonId)? onCompleteLesson;
  final String? completionType;
  final String itemType;
  final String headerTitle;
  final String? headerSubtitle;

  @override
  State<LearnLevelFourScreen> createState() => _LearnLevelFourScreenState();
}

class _LearnLevelFourScreenState extends State<LearnLevelFourScreen>
    with LearnLevelSharedFlowMixin<LearnLevelFourScreen> {
  bool _showLessonDetails = false;
  String? _selectedLetter;

  final List<String> _lettersList = ['P', 'Q', 'Z', 'J'];

  List<String> get _items => widget.items ?? _lettersList;

  @override
  bool get isPracticeMode => widget.ispractise;

  @override
  String get itemTypeLabel => widget.itemType;

  @override
  Map<String, int> get routeItemIds => widget.lessonIdsByItem;

  @override
  String? get routeCompletionType => widget.completionType;

  @override
  Future<void> Function(int itemId)? get routeCompleteCallback =>
      widget.onCompleteLesson;

  @override
  String get levelLabel => 'Level Four';

  @override
  List<String> get levelItems => _items;

  @override
  String? get selectedLessonTitle => _selectedLetter;

  @override
  set selectedLessonTitle(String? value) => _selectedLetter = value;

  @override
  bool get isShowingLessonDetails => _showLessonDetails;

  @override
  set isShowingLessonDetails(bool value) => _showLessonDetails = value;

  @override
  Future<void> onLessonMarkedCompleted(String item) async {
    final lessonId = widget.lessonIdsByItem[item];
    if (lessonId == null || widget.onCompleteLesson == null) {
      return;
    }

    await widget.onCompleteLesson!(lessonId);
  }

  @override
  void initState() {
    super.initState();
    if (widget.ispractise) {
      unawaited(prewarmTestLevelModel());
    }
  }

  void _goBackToLevels() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _showLessonDetails
                ? LesseonDetailsScreen(
                    letter: _selectedLetter ?? lessonTitleForItem(_items.first),
                    onBack: goBackFromLesson,
                    onNext: goToNextLesson,
                    isCompleting: widget.completingLessonId ==
                        widget.lessonIdsByItem[(_selectedLetter ??
                                lessonTitleForItem(_items.first))
                            .split(' ')
                            .last],
                  )
                : SingleChildScrollView(
                    key: const ValueKey('levelFourList'),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: widget.onBack != null ? 76.h : 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppAsset(
                              assetName: Assets.youngwomanwritingnotebook,
                              width: 100.w,
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Column(
                              children: [
                                AppText(
                                  widget.headerTitle,
                                  style: font16w700,
                                  alignment: AlignmentDirectional.center,
                                ),
                                AppText(
                                  widget.headerSubtitle ?? _items.join(' '),
                                  style: font16w700,
                                  alignment: AlignmentDirectional.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            AppAsset(
                              assetName: Assets
                                  .sideviewofyoungmanwearingsmartwatchandholdingbook,
                              width: 80.w,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        ..._items.map(
                          (item) {
                            final isCompleted =
                                widget.completedItems.contains(item);
                            return CourseCard(
                              title: 'Level Four',
                              subtitle: '${widget.itemType} $item',
                              completetext: isCompleted
                                  ? '1 of 1 Completed'
                                  : '0 of 1 Completed',
                              value: isCompleted ? 1 : 0,
                              onTap: () => openLesson(item),
                              isPractice: widget.ispractise,
                            );
                          },
                        ).toList(),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
          ),
          if (widget.onBack != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: HomeAppbar(
                title: _showLessonDetails
                    ? (_selectedLetter ?? 'Level Four')
                    : 'Level Four',
                onBack: _showLessonDetails ? goBackFromLesson : _goBackToLevels,
              ),
            ),
        ],
      ),
    );
  }
}
