import 'package:flutter/material.dart';

class TestScreenLevelData {
  const TestScreenLevelData({
    required this.id,
    required this.label,
    required this.assetName,
    required this.words,
    required this.wordIds,
    required this.completedItems,
    required this.completedWords,
    required this.alignment,
    required this.keyName,
  });

  final int id;
  final String label;
  final String assetName;
  final List<String> words;
  final Map<String, int> wordIds;
  final Set<String> completedItems;
  final int completedWords;
  final Alignment alignment;
  final String keyName;
}
