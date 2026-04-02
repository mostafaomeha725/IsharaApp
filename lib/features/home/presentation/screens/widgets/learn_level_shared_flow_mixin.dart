import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

mixin LearnLevelSharedFlowMixin<T extends StatefulWidget> on State<T> {
  bool get isPracticeMode;
  String get itemTypeLabel;
  String get levelLabel;
  List<String> get levelItems;

  String? get selectedLessonTitle;
  set selectedLessonTitle(String? value);

  bool get isShowingLessonDetails;
  set isShowingLessonDetails(bool value);

  String lessonTitleForItem(String item) {
    return '$levelLabel $itemTypeLabel $item';
  }

  void openLesson(String item) {
    final String fullTitle = lessonTitleForItem(item);

    if (isPracticeMode) {
      context.push(Routes.practisedetails, extra: fullTitle);
      return;
    }

    setState(() {
      selectedLessonTitle = fullTitle;
      isShowingLessonDetails = true;
    });
  }

  void goToNextLesson() {
    final String? currentTitle = selectedLessonTitle;
    if (currentTitle == null) return;

    final String currentItem = currentTitle.split(' ').last;
    final int currentIndex = levelItems.indexOf(currentItem);

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
