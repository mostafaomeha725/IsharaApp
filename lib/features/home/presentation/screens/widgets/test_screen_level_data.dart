import 'package:flutter/material.dart';
import 'package:isharaapp/core/constants/app_assets.dart';

class TestScreenLevelData {
  const TestScreenLevelData({
    required this.id,
    required this.label,
    required this.assetName,
    required this.words,
    required this.alignment,
    required this.keyName,
  });

  final int id;
  final String label;
  final String assetName;
  final List<String> words;
  final Alignment alignment;
  final String keyName;
}

const List<String> _levelOneWords = [
  'able',
  'love',
  'buy',
  'cube',
  'wavy',
  'bowl',
  'claw',
  'you',
  'clay',
  'clue',
];

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

const List<String> _levelThreeWords = [
  'foxy',
  'onyx',
  'gown',
  'honk',
  'minx',
  'hack',
  'claw',
  'hawk',
  'hack',
  'numb',
];

const List<String> _levelFourWords = [
  'quiz',
  'mazy',
  'jive',
  'vape',
  'jump',
  'quiz',
  'squiz',
  'equip',
  'czar',
  'pivot',
];

const List<TestScreenLevelData> testScreenLevels = [
  TestScreenLevelData(
    id: 1,
    label: 'Level One',
    assetName: Assets.book1,
    words: _levelOneWords,
    alignment: Alignment(-0.88, -0.88),
    keyName: 'testLevelOneWords',
  ),
  TestScreenLevelData(
    id: 2,
    label: 'Level Two',
    assetName: Assets.book2,
    words: _levelTwoWords,
    alignment: Alignment(0.88, -0.62),
    keyName: 'testLevelTwoWords',
  ),
  TestScreenLevelData(
    id: 3,
    label: 'Level Three',
    assetName: Assets.book3,
    words: _levelThreeWords,
    alignment: Alignment(-0.88, -0.32),
    keyName: 'testLevelThreeWords',
  ),
  TestScreenLevelData(
    id: 4,
    label: 'Level Four',
    assetName: Assets.book4,
    words: _levelFourWords,
    alignment: Alignment(0.88, 0.06),
    keyName: 'testLevelFourWords',
  ),
];
