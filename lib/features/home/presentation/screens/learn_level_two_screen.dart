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

class LearnLevelTwoScreen extends StatefulWidget {
  const LearnLevelTwoScreen({
    super.key,
    required this.ispractise,
    this.onBack,
    this.items,
    this.itemType = 'Letter',
    this.headerTitle = 'letters',
    this.headerSubtitle,
  });

  final bool ispractise;
  final VoidCallback? onBack;
  final List<String>? items;
  final String itemType;
  final String headerTitle;
  final String? headerSubtitle;

  @override
  State<LearnLevelTwoScreen> createState() => _LearnLevelTwoScreenState();
}

class _LearnLevelTwoScreenState extends State<LearnLevelTwoScreen>
    with LearnLevelSharedFlowMixin<LearnLevelTwoScreen> {
  bool _showLessonDetails = false;
  String? _selectedLetter;

  final List<String> _lettersList = ['D', 'F', 'K', 'R', 'S', 'I', 'T'];

  List<String> get _items => widget.items ?? _lettersList;

  @override
  bool get isPracticeMode => widget.ispractise;

  @override
  String get itemTypeLabel => widget.itemType;

  @override
  String get levelLabel => 'Level Two';

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
                  )
                : SingleChildScrollView(
                    key: const ValueKey('levelTwoList'),
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
                        ..._items
                            .map(
                              (item) => CourseCard(
                                title: 'Level Two',
                                subtitle: '${widget.itemType} $item',
                                completetext: '0 of 1 Completed',
                                value: 0,
                                onTap: () => openLesson(item),
                                isPractice: widget.ispractise,
                              ),
                            )
                            .toList(),
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
                    ? (_selectedLetter ?? 'Level Two')
                    : 'Level Two',
                onBack: _showLessonDetails ? goBackFromLesson : _goBackToLevels,
              ),
            ),
        ],
      ),
    );
  }
}
