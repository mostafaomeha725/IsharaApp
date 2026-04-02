import 'dart:async';

import 'package:flutter/material.dart';

class TestLevelLoadingGateController extends ChangeNotifier {
  TestLevelLoadingGateController({
    this.delay = const Duration(milliseconds: 450),
  });

  final Duration delay;

  Timer? _timer;
  bool _allowOverlay = false;

  bool get allowOverlay => _allowOverlay;

  void update({
    required bool isLoading,
    required bool Function() isStillLoading,
  }) {
    if (isLoading) {
      _timer?.cancel();
      _setAllowOverlay(false);

      _timer = Timer(delay, () {
        _timer = null;

        if (isStillLoading()) {
          _setAllowOverlay(true);
        }
      });
      return;
    }

    _timer?.cancel();
    _timer = null;
    _setAllowOverlay(false);
  }

  void _setAllowOverlay(bool value) {
    if (_allowOverlay == value) {
      return;
    }

    _allowOverlay = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
