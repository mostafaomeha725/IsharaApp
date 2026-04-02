import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';

import 'package:isharaapp/features/home/presentation/cubit/test_level_cubit.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_runtime_helpers.dart';

class TestLevelRuntimeController extends ChangeNotifier {
  TestLevelRuntimeController({
    required this.testLevelCubit,
    required this.cleanWord,
    this.preferredCamera,
  });

  static const Duration startupDelay = Duration(milliseconds: 500);
  static const Duration analysisInterval = Duration(milliseconds: 1000);
  static const Duration streamStartDelay = Duration(milliseconds: 220);
  static const Duration initializationTimeout = Duration(seconds: 15);

  final TestLevelCubit testLevelCubit;
  final String cleanWord;
  final CameraDescription? preferredCamera;

  CameraController? _controller;
  FlutterVision? _vision;

  bool _isCameraInitialized = false;
  bool _isModelLoaded = false;
  bool _isFlashOn = false;
  bool _isStopping = false;
  bool _isProcessing = false;
  bool _isStreamActive = false;
  bool _isDisposed = false;

  DateTime _lastAnalysisTime = DateTime.now();

  CameraController? get controller => _controller;
  bool get isCameraInitialized => _isCameraInitialized;
  bool get isModelLoaded => _isModelLoaded;
  bool get isFlashOn => _isFlashOn;
  bool get isLoading => !_isCameraInitialized || !_isModelLoaded;

  Future<void> startLoadingProcess() async {
    testLevelCubit.setLoading();

    if (!isSharedVisionModelReady()) {
      await Future.delayed(startupDelay);
    }

    if (_isDisposed) {
      return;
    }

    try {
      await _initializeRuntime().timeout(initializationTimeout);
    } on TimeoutException {
      debugPrint('Runtime initialization timed out.');
      testLevelCubit.setFailure('Starting camera took too long. Please retry.');
    }
  }

  Future<void> _initializeRuntime() async {
    try {
      final runtime = await bootstrapTestLevelRuntime(
        preferredCamera: preferredCamera,
      );

      if (_isDisposed) {
        await closeRuntimeResources(
          controller: runtime.controller,
          vision: runtime.vision,
        );
        return;
      }

      _vision = runtime.vision;
      _controller = runtime.controller;

      _isModelLoaded = true;
      _isCameraInitialized = true;
      _isFlashOn = false;
      _notifyStateChanged();
      testLevelCubit.setReady();

      // Delay streaming briefly so route transition and first frame render stay smooth.
      unawaited(_startImageStream());
    } catch (e) {
      debugPrint('Runtime Initialization Error: $e');
      testLevelCubit.setFailure('Failed to initialize camera. Please retry.');
    }
  }

  Future<void> _startImageStream() async {
    final controller = _controller;
    if (controller == null || _isDisposed || _isStopping || _isStreamActive) {
      return;
    }

    await Future.delayed(streamStartDelay);

    if (_isDisposed || _isStopping || _isStreamActive) {
      return;
    }

    if (!controller.value.isInitialized) {
      return;
    }

    if (controller.value.isStreamingImages) {
      _isStreamActive = true;
      return;
    }

    try {
      await controller.startImageStream((CameraImage image) {
        if (_isStopping ||
            _isDisposed ||
            testLevelCubit.state.isLevelCompleted) {
          return;
        }

        if (!_isProcessing) {
          unawaited(_processCameraFrame(image));
        }
      });

      _isStreamActive = true;
    } catch (e) {
      debugPrint('Image Stream Start Error: $e');
      testLevelCubit.setFailure('Failed to start camera stream. Please retry.');
    }
  }

  Future<void> _processCameraFrame(CameraImage image) async {
    final vision = _vision;
    if (vision == null) {
      return;
    }

    final now = DateTime.now();
    if (isFrameAnalysisThrottled(
      now: now,
      lastAnalysisTime: _lastAnalysisTime,
      analysisInterval: analysisInterval,
    )) {
      return;
    }

    _isProcessing = true;
    _lastAnalysisTime = now;

    try {
      final results = await runYoloOnFrame(vision: vision, image: image);

      if (_isDisposed || _isStopping || testLevelCubit.state.isLevelCompleted) {
        return;
      }

      if (results.isEmpty) {
        testLevelCubit.markNoHandFound();
        return;
      }

      final topResult = pickTopResult(results);
      final String detectedLabel = extractDetectedLabel(topResult);

      testLevelCubit.onDetection(
        detectedLabel: detectedLabel,
        cleanWord: cleanWord,
      );
    } catch (e) {
      debugPrint('Analysis Error: $e');
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> retryInitialization() async {
    await closeRuntimeResources(controller: _controller, vision: _vision);

    _controller = null;
    _vision = null;
    _isCameraInitialized = false;
    _isModelLoaded = false;
    _isProcessing = false;
    _isStopping = false;
    _isStreamActive = false;
    _isFlashOn = false;
    _lastAnalysisTime = DateTime.now();

    _notifyStateChanged();
    await startLoadingProcess();
  }

  Future<void> toggleFlash() async {
    final controller = _controller;
    if (!_isCameraInitialized || controller == null) {
      return;
    }

    if (!controller.value.isInitialized) {
      return;
    }

    try {
      final nextFlashState = await toggleFlashSafely(
        controller: controller,
        currentFlashState: _isFlashOn,
      );
      _isFlashOn = nextFlashState;
      _notifyStateChanged();
    } catch (e) {
      debugPrint('Flash Error: $e');
      _isFlashOn = false;
      _notifyStateChanged();
    }
  }

  Future<void> stopStreaming() async {
    if (_isStopping) {
      return;
    }

    _isStopping = true;

    try {
      await stopImageStreamSafely(_controller);
      _isStreamActive = false;
    } catch (e) {
      debugPrint('Error stopping stream: $e');
    }
  }

  Future<void> handleLifecycleChange(AppLifecycleState state) async {
    final controller = _controller;

    if (!_isCameraInitialized || controller == null) {
      return;
    }

    if (!controller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      await closeRuntimeResources(controller: controller, vision: null);
      _controller = null;
      _isCameraInitialized = false;
      _isStreamActive = false;
      _isFlashOn = false;
      _notifyStateChanged();
      return;
    }

    if (state == AppLifecycleState.resumed) {
      await retryInitialization();
    }
  }

  Future<void> disposeRuntime() async {
    _isStopping = true;
    _isStreamActive = false;
    await closeRuntimeResources(controller: _controller, vision: _vision);
    _controller = null;
    _vision = null;
  }

  void _notifyStateChanged() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
