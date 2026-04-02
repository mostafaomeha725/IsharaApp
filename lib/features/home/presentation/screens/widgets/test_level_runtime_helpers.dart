import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vision/flutter_vision.dart';

FlutterVision? _sharedVisionModel;
bool _isSharedModelLoaded = false;
Future<FlutterVision>? _modelLoadingTask;

class TestLevelRuntimeBootstrap {
  const TestLevelRuntimeBootstrap({
    required this.vision,
    required this.controller,
  });

  final FlutterVision vision;
  final CameraController controller;
}

String normalizeWord(String word) {
  return word.replaceAll(' ', '').trim().toUpperCase();
}

Future<TestLevelRuntimeBootstrap> bootstrapTestLevelRuntime({
  CameraDescription? preferredCamera,
}) async {
  final vision = await getOrLoadSharedVisionModel();

  final camera = await resolveBackCamera(preferredCamera: preferredCamera);

  final controller = CameraController(
    camera,
    ResolutionPreset.low,
    enableAudio: false,
    imageFormatGroup: Platform.isAndroid
        ? ImageFormatGroup.yuv420
        : ImageFormatGroup.bgra8888,
  );

  await controller.initialize();
  await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
  await controller.setFlashMode(FlashMode.off);
  await controller.setFocusMode(FocusMode.auto);

  return TestLevelRuntimeBootstrap(vision: vision, controller: controller);
}

Future<FlutterVision> getOrLoadSharedVisionModel() async {
  if (_sharedVisionModel != null && _isSharedModelLoaded) {
    return _sharedVisionModel!;
  }

  if (_modelLoadingTask != null) {
    return _modelLoadingTask!;
  }

  final model = _sharedVisionModel ?? FlutterVision();
  _sharedVisionModel = model;

  _modelLoadingTask = () async {
    await model.loadYoloModel(
      modelPath: 'assets/model/best_float16.tflite',
      labels: 'assets/model/labels.txt',
      modelVersion: 'yolov8',
      numThreads: 2,
      useGpu: true,
    );

    _isSharedModelLoaded = true;
    return model;
  }();

  try {
    return await _modelLoadingTask!;
  } finally {
    _modelLoadingTask = null;
  }
}

Future<void> prewarmTestLevelModel() async {
  await getOrLoadSharedVisionModel();
}

bool isSharedVisionModelReady() {
  return _sharedVisionModel != null && _isSharedModelLoaded;
}

Future<CameraDescription> resolveBackCamera({
  CameraDescription? preferredCamera,
}) async {
  final cameras = await availableCameras();

  // Always prefer the rear camera so torch/flash is available.
  final backCameras = cameras
      .where((camera) => camera.lensDirection == CameraLensDirection.back)
      .toList();

  if (backCameras.isNotEmpty) {
    return backCameras.first;
  }

  if (preferredCamera != null) {
    return preferredCamera;
  }

  return cameras.first;
}

bool isFrameAnalysisThrottled({
  required DateTime now,
  required DateTime lastAnalysisTime,
  required Duration analysisInterval,
}) {
  return now.difference(lastAnalysisTime) < analysisInterval;
}

Future<List<dynamic>> runYoloOnFrame({
  required FlutterVision vision,
  required CameraImage image,
}) {
  return vision.yoloOnFrame(
    bytesList: image.planes.map((plane) => plane.bytes).toList(),
    imageHeight: image.height,
    imageWidth: image.width,
    iouThreshold: 0.3,
    confThreshold: 0.3,
    classThreshold: 0.3,
  );
}

dynamic pickTopResult(List<dynamic> results) {
  results.sort(
    (a, b) => (b['box'][4] as double).compareTo(a['box'][4] as double),
  );
  return results.first;
}

String extractDetectedLabel(dynamic topResult) {
  return topResult['tag'].toString().trim().toUpperCase();
}

Future<bool> toggleFlashSafely({
  required CameraController controller,
  required bool currentFlashState,
}) async {
  final bool nextState = !currentFlashState;

  if (nextState) {
    try {
      await controller.setFlashMode(FlashMode.torch);
    } catch (_) {
      await controller.setFlashMode(FlashMode.always);
    }
  } else {
    await controller.setFlashMode(FlashMode.off);
  }

  final currentMode = controller.value.flashMode;

  if (nextState) {
    return currentMode == FlashMode.torch || currentMode == FlashMode.always;
  }

  return currentMode == FlashMode.off;
}

Future<void> stopImageStreamSafely(CameraController? controller) async {
  if (controller == null || !controller.value.isInitialized) {
    return;
  }

  if (controller.value.isStreamingImages) {
    await controller.stopImageStream();
  }
}

Future<void> closeRuntimeResources({
  required CameraController? controller,
  required FlutterVision? vision,
  bool closeVisionModel = false,
}) async {
  if (controller != null) {
    try {
      await stopImageStreamSafely(controller);
    } catch (_) {}

    try {
      await controller.dispose();
    } catch (_) {}
  }

  if (closeVisionModel && vision != null) {
    vision.closeYoloModel();

    if (identical(vision, _sharedVisionModel)) {
      _sharedVisionModel = null;
      _isSharedModelLoaded = false;
    }
  }
}
