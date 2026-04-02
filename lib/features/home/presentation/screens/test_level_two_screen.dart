import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/features/home/presentation/screens/learn_level_two_screen.dart';

const List<String> _levelTwoWords = [
  'risk',
  'sir',
  'dirt',
  'kids',
  'verb',
  'dark',
  'four',
  'draw',
  'feud',
  'cake',
];

class TestLevelTwoScreen extends StatelessWidget {
  final CameraDescription camera;

  const TestLevelTwoScreen({
    super.key,
    required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    return LearnLevelTwoScreen(
      ispractise: true,
      onBack: () => context.pop(),
      items: _levelTwoWords,
      itemType: 'Word',
      headerTitle: 'words',
      headerSubtitle: 'Choose a word from cards below',
    );
  }
}
