import 'package:flutter/material.dart';

enum GenderTheme { boy, girl }

class GenderController extends InheritedWidget {
  final GenderTheme genderTheme;
  final ValueChanged<GenderTheme> onGenderChanged;

  const GenderController({
    super.key,
    required this.genderTheme,
    required this.onGenderChanged,
    required super.child,
  });

  static GenderController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GenderController>()!;
  }

  @override
  bool updateShouldNotify(GenderController oldWidget) =>
      genderTheme != oldWidget.genderTheme;
}
