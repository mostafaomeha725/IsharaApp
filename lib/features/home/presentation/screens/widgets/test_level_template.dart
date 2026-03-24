import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vision/flutter_vision.dart';

import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_appbar.dart';

class TestLevelTemplate extends StatefulWidget {
  final String title;
  final String word;
  final VoidCallback onBackPressed;
  final CameraDescription? camera;

  const TestLevelTemplate({
    super.key,
    required this.title,
    required this.word,
    required this.onBackPressed,
    this.camera,
  });

  @override
  State<TestLevelTemplate> createState() => _TestLevelTemplateState();
}

class _TestLevelTemplateState extends State<TestLevelTemplate>
    with WidgetsBindingObserver {
  late CameraController _controller;
  late FlutterVision _vision;
  bool _isCameraInitialized = false;
  bool _isModelLoaded = false;
  bool _isFlashOn = false;
  bool _isStopping = false;

  // 🔹 متغيرات تتابع الكلمة (Logic Variables)
  int _currentIndex = 0; // مؤشر الحرف الحالي
  bool _isLevelCompleted = false; // هل انتهت الكلمة؟
  Timer? _transitionTimer; // تايمر للنقل بين الحروف

  // متغيرات الأداء
  bool _isProcessing = false;
  DateTime _lastAnalysisTime = DateTime.now();

  // متغيرات الحالة والأنيميشن
  String _accuracy = "0%";
  String _statusMessage = "Ready...";
  Color _statusColor = Colors.white;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // 🔥 التعديل: نستنى لما الصفحة تترسم بالكامل قبل ما نبدأ أي حاجة تقيلة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startLoadingProcess();
    });
  }

  // دالة منفصلة لادارة عملية البدء بتأخير عشان اللودينج ميهنجش
  Future<void> _startLoadingProcess() async {
    // ندي فرصة لل UI يتنفس ويعرض اللودينج
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      _initializeModel();
    }
  }

  Future<void> _initializeModel() async {
    _vision = FlutterVision();
    try {
      await _vision.loadYoloModel(
        modelPath: 'assets/model/best_float16.tflite',
        labels: 'assets/model/labels.txt',
        modelVersion: "yolov8",
        numThreads: 2,
        useGpu: true,
      );

      if (mounted) {
        setState(() {
          _isModelLoaded = true;
        });
      }

      await _initializeCamera();
    } catch (e) {
      debugPrint("❌ Model Error: $e");
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        backCamera,
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.yuv420
            : ImageFormatGroup.bgra8888,
      );

      await _controller.initialize();
      await _controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
      await _controller.setFlashMode(FlashMode.off);
      await _controller.setFocusMode(FocusMode.auto);

      _controller.startImageStream((CameraImage image) {
        if (_isStopping || !_isModelLoaded || _isLevelCompleted) return;
        if (!_isProcessing && mounted) {
          _processCameraFrame(image);
        }
      });

      if (mounted) setState(() => _isCameraInitialized = true);
    } catch (e) {
      debugPrint("Camera Error: $e");
    }
  }

  // 🔹 دالة المعالجة
  Future<void> _processCameraFrame(CameraImage image) async {
    if (DateTime.now().difference(_lastAnalysisTime) <
        const Duration(milliseconds: 1000)) {
      return;
    }

    _isProcessing = true;
    _lastAnalysisTime = DateTime.now();

    try {
      final results = await _vision.yoloOnFrame(
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        iouThreshold: 0.3,
        confThreshold: 0.3,
        classThreshold: 0.3,
      );

      if (!mounted || _isStopping || _isLevelCompleted) return;

      if (results.isNotEmpty) {
        results.sort(
            (a, b) => (b['box'][4] as double).compareTo(a['box'][4] as double));
        final topResult = results.first;

        String detectedLabel = topResult['tag'].toString().trim().toUpperCase();
        String cleanWord = widget.word.replaceAll(' ', '').trim().toUpperCase();

        if (_currentIndex >= cleanWord.length) return;

        String targetChar = cleanWord[_currentIndex];
        double confidence = topResult['box'][4] * 100;

        debugPrint(
            "👉 Detected: '$detectedLabel' | Target: '$targetChar' | Conf: $confidence");

        setState(() {
          _accuracy = "${confidence.toStringAsFixed(0)}%";

          if (detectedLabel == targetChar) {
            if (confidence >= 40) {
              _statusMessage = "Excellent! 🎉";
              _statusColor = Colors.green;
              _isSuccess = true;

              if (_transitionTimer == null || !_transitionTimer!.isActive) {
                _transitionTimer = Timer(const Duration(milliseconds: 500), () {
                  if (mounted) {
                    setState(() {
                      _currentIndex++;
                      _isSuccess = false;

                      if (_currentIndex >= cleanWord.length) {
                        _isLevelCompleted = true;
                        _statusMessage = "LEVEL COMPLETE!";
                        _statusColor = Colors.blue;
                      } else {
                        _statusMessage = "Next: ${cleanWord[_currentIndex]}";
                        _statusColor = Colors.orange;
                      }
                    });
                  }
                });
              }
            } else {
              _statusMessage = "Hold Steady...";
              _statusColor = Colors.yellow;
              _isSuccess = false;
            }
          } else {
            _statusMessage = "Wrong: saw '$detectedLabel'";
            _statusColor = Colors.red;
            _isSuccess = false;
          }
        });
      } else {
        setState(() {
          _statusMessage = "No Hand Found";
          _statusColor = Colors.orange;
          _accuracy = "0%";
          _isSuccess = false;
        });
      }
    } catch (e) {
      debugPrint("Analysis Error: $e");
    } finally {
      if (mounted) _isProcessing = false;
    }
  }

  Future<void> _safeExit() async {
    if (_isStopping) return;
    _isStopping = true;
    _transitionTimer?.cancel();
    try {
      if (_isCameraInitialized && _controller.value.isStreamingImages) {
        await _controller.stopImageStream();
      }
    } catch (e) {
      debugPrint("Error stopping stream: $e");
    }
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) widget.onBackPressed();
  }

  Future<void> _toggleFlash() async {
    if (!_isCameraInitialized || !_controller.value.isInitialized) return;
    try {
      _isFlashOn = !_isFlashOn;
      await _controller
          .setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
      setState(() {});
    } catch (e) {
      debugPrint("Flash Error: $e");
    }
  }

  @override
  void dispose() {
    _isStopping = true;
    _transitionTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    if (_isModelLoaded) _vision.closeYoloModel();
    if (_isCameraInitialized) _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isCameraInitialized || !_controller.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);

    // ⚡ متغير التحميل
    bool isLoading = !_isCameraInitialized || !_isModelLoaded;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          _safeExit();
        },
        child: SafeArea(
          child: Stack(
            children: [
              // 1. الخلفية
              AppAsset(
                assetName: themeController.themeMode == ThemeMode.dark
                    ? Assets.splashdark
                    : Assets.splashlight,
              ),

              // 2. المحتوى الرئيسي (مخفي أثناء التحميل)
              if (!isLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomAppBarRow(title: widget.title, onBack: _safeExit),
                        SizedBox(height: 16.h),
                        _buildWordProgress(context),
                        SizedBox(height: 16.h),
                        _buildVideoBox(context),
                        SizedBox(height: 20.h),
                        _buildAnimatedStatusBox(),
                        SizedBox(height: 20.h),
                        _buildTips(context),
                        SizedBox(height: 16.h),
                        AppButton(
                          text: _isLevelCompleted ? 'Finish' : 'Back',
                          onPressed: _safeExit,
                          textColor: themeController.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                          color: _isLevelCompleted
                              ? Colors.green
                              : Colors.transparent,
                          radius: 32.r,
                          borderColor:
                              themeController.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),

              // 3. شاشة التحميل (تظهر فوراً)
              if (isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context)
                      .scaffoldBackgroundColor, // خلفية كاملة عشان تغطي
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 50.h,
                        child: const CircularProgressIndicator(strokeWidth: 3),
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        "Starting Camera...",
                        style: font18w700.copyWith(
                            color: themeController.themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Please wait...",
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 ويدجت عرض الكلمة
  Widget _buildWordProgress(BuildContext context) {
    String cleanWord = widget.word.replaceAll(' ', '').toUpperCase();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12.w,
        runSpacing: 10.h,
        children: List.generate(cleanWord.length, (index) {
          bool isCompleted = index < _currentIndex;
          bool isCurrent = index == _currentIndex;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green
                  : (isCurrent ? Colors.orange : Colors.grey.withOpacity(0.2)),
              shape: BoxShape.circle,
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                          color: Colors.orange.withOpacity(0.6),
                          blurRadius: 12,
                          spreadRadius: 1)
                    ]
                  : [],
              border:
                  isCurrent ? Border.all(color: Colors.white, width: 2) : null,
            ),
            child: Text(
              cleanWord[index],
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: isCompleted || isCurrent ? Colors.white : Colors.grey,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAnimatedStatusBox() {
    return AnimatedScale(
      scale: _isSuccess || _isLevelCompleted ? 1.1 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
        decoration: BoxDecoration(
          color: _isLevelCompleted
              ? Colors.blue
              : (_statusColor == Colors.green
                  ? Colors.green
                  : _statusColor == Colors.orange
                      ? Colors.orangeAccent
                      : _statusColor == Colors.red
                          ? Colors.redAccent
                          : Colors.blueAccent),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color:
                  _isSuccess ? Colors.green.withOpacity(0.5) : Colors.black26,
              blurRadius: _isSuccess ? 15 : 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isLevelCompleted
                  ? Icons.star
                  : (_isSuccess ? Icons.check_circle : Icons.camera),
              color: Colors.white,
              size: 24.sp,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                _statusMessage,
                style: font18w700.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoBox(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: _isSuccess ? Colors.green : Colors.grey.withOpacity(0.5),
          width: _isSuccess ? 4 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isCameraInitialized)
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CameraPreview(_controller),
              )
            else
              const Center(
                  child: CircularProgressIndicator(color: Colors.white)),
            if (_isCameraInitialized)
              Positioned(
                top: 10.h,
                right: 10.w,
                child: IconButton(
                  onPressed: _toggleFlash,
                  icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white, size: 28.sp),
                  style: IconButton.styleFrom(backgroundColor: Colors.black38),
                ),
              ),
            if (!_isLevelCompleted &&
                _currentIndex < widget.word.replaceAll(' ', '').length)
              Positioned(
                top: 20.h,
                left: 20.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                      "Target: ${widget.word.replaceAll(' ', '')[_currentIndex].toUpperCase()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            Positioned(
              bottom: 24.h,
              child: Column(
                children: [
                  Text("Confidence",
                      style: font14w500.copyWith(color: Colors.white70)),
                  Text(_accuracy,
                      style: font32w700.copyWith(
                          fontSize: 36.sp, color: _statusColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTips(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Tips:",
              style: font16w700.copyWith(
                  color: ThemeController.of(context).themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black)),
        ),
        _buildTipRow(context, "Spell one letter at a time"),
        _buildTipRow(context, "Wait for green light to proceed"),
      ],
    );
  }

  Widget _buildTipRow(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ",
              style: font18w700.copyWith(
                  color: ThemeController.of(context).themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black)),
          Expanded(
              child: Text(text,
                  style: font16w700.copyWith(
                      color: ThemeController.of(context).themeMode ==
                              ThemeMode.dark
                          ? Colors.white
                          : Colors.black))),
        ],
      ),
    );
  }
}
