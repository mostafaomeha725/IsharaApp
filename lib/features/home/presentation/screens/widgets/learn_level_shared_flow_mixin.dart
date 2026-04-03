import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

mixin LearnLevelSharedFlowMixin<T extends StatefulWidget> on State<T> {
  bool get isPracticeMode;
  String get itemTypeLabel;
  String get levelLabel;
  List<String> get levelItems;
  Map<String, int> get routeItemIds => const <String, int>{};
  String? get routeCompletionType => null;
  Future<void> Function(int itemId)? get routeCompleteCallback => null;

  String? get selectedLessonTitle;
  set selectedLessonTitle(String? value);

  bool get isShowingLessonDetails;
  set isShowingLessonDetails(bool value);

  String lessonTitleForItem(String item) {
    return '$levelLabel $itemTypeLabel $item';
  }

  Future<void> onLessonMarkedCompleted(String item) async {}

  void openLesson(String item) {
    final String fullTitle = lessonTitleForItem(item);

    if (isPracticeMode) {
      context.push(
        Routes.practisedetails,
        extra: {
          'title': fullTitle,
          'words': [item],
          'completionId': routeItemIds[item],
          'completionType': routeCompletionType,
          'onComplete': routeCompleteCallback,
        },
      );
      return;
    }

    setState(() {
      selectedLessonTitle = fullTitle;
      isShowingLessonDetails = true;
    });
  }

  void goToNextLesson() {
    unawaited(_goToNextLessonInternal());
  }

  Future<void> _goToNextLessonInternal() async {
    final String? currentTitle = selectedLessonTitle;
    if (currentTitle == null) return;

    final String currentItem = currentTitle.split(' ').last;
    final int currentIndex = levelItems.indexOf(currentItem);

    await onLessonMarkedCompleted(currentItem);
    if (!mounted) {
      return;
    }

    if (currentIndex != -1 && currentIndex < levelItems.length - 1) {
      final String nextItem = levelItems[currentIndex + 1];
      setState(() {
        selectedLessonTitle = lessonTitleForItem(nextItem);
      });
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: AppText('You have completed all the letters!'),
      ),
    );
  }

  void goBackFromLesson() {
    setState(() {
      isShowingLessonDetails = false;
      selectedLessonTitle = null;
    });
  }
}
