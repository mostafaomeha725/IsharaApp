import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/features/home/presentation/cubit/test_level_cubit.dart';
import 'package:isharaapp/features/home/presentation/cubit/test_level_state.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_camera_box.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_celebration_overlay.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_failure_overlay.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_loading_gate_controller.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_loading_overlay.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_status_box.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_tips_section.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_word_progress.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_runtime_controller.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_runtime_helpers.dart';

class TestLevelTemplate extends StatefulWidget {
  final String title;
  final String word;
  final VoidCallback onBackPressed;
  final CameraDescription? camera;
  final int? completionId;
  final String? completionType;
  final Future<void> Function(int itemId)? onComplete;

  const TestLevelTemplate({
    super.key,
    required this.title,
    required this.word,
    required this.onBackPressed,
    this.camera,
    this.completionId,
    this.completionType,
    this.onComplete,
  });

  @override
  State<TestLevelTemplate> createState() => _TestLevelTemplateState();
}

class _TestLevelTemplateState extends State<TestLevelTemplate>
    with WidgetsBindingObserver {
  late final TestLevelCubit _testLevelCubit;
  late final TestLevelRuntimeController _runtimeController;
  late final TestLevelLoadingGateController _loadingGateController;
  bool _completionSubmitted = false;

  String get _cleanWord => normalizeWord(widget.word);

  bool get _isAppLoading {
    final status = _testLevelCubit.state.viewStatus;
    return status == TestLevelViewStatus.initial ||
        status == TestLevelViewStatus.loading;
  }

  @override
  void initState() {
    super.initState();
    _testLevelCubit = TestLevelCubit();
    _loadingGateController = TestLevelLoadingGateController()
      ..addListener(_onLoadingGateChanged);

    _runtimeController = TestLevelRuntimeController(
      testLevelCubit: _testLevelCubit,
      cleanWord: _cleanWord,
      preferredCamera: widget.camera,
    )..addListener(_onRuntimeChanged);

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncLoadingGate(true);
      _runtimeController.startLoadingProcess();
    });
  }

  void _onLoadingGateChanged() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  void _onRuntimeChanged() {
    if (!mounted) {
      return;
    }

    _syncLoadingGate(_isAppLoading);

    setState(() {});
  }

  void _syncLoadingGate(bool isLoading) {
    _loadingGateController.update(
      isLoading: isLoading,
      isStillLoading: () => _isAppLoading,
    );
  }

  Future<void> _safeExit() async {
    await _runtimeController.stopStreaming();

    await Future.delayed(const Duration(milliseconds: 100));

    if (mounted) widget.onBackPressed();
  }

  Future<void> _retryInitialization() async {
    _syncLoadingGate(true);
    await _runtimeController.retryInitialization();
  }

  Future<void> _toggleFlash() async {
    await _runtimeController.toggleFlash();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _loadingGateController.removeListener(_onLoadingGateChanged);
    _loadingGateController.dispose();
    _runtimeController.removeListener(_onRuntimeChanged);
    unawaited(_runtimeController.disposeRuntime());
    _runtimeController.dispose();
    _testLevelCubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    unawaited(_runtimeController.handleLifecycleChange(state));
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);

    return BlocProvider.value(
      value: _testLevelCubit,
      child: BlocConsumer<TestLevelCubit, TestLevelState>(
        listener: (context, state) {
          final isLoading = state.viewStatus == TestLevelViewStatus.initial ||
              state.viewStatus == TestLevelViewStatus.loading;
          _syncLoadingGate(isLoading);

          if (state.isLevelCompleted &&
              !_completionSubmitted &&
              widget.completionId != null &&
              widget.completionId! > 0 &&
              widget.onComplete != null) {
            _completionSubmitted = true;
            unawaited(widget.onComplete!(widget.completionId!));
          }
        },
        builder: (context, state) {
          final bool isDarkMode = themeController.themeMode == ThemeMode.dark;
          final bool isLoadingNow =
              state.viewStatus == TestLevelViewStatus.initial ||
                  state.viewStatus == TestLevelViewStatus.loading;
          final bool showLoading =
              isLoadingNow && _loadingGateController.allowOverlay;
          final bool showFailure =
              state.viewStatus == TestLevelViewStatus.failure;
          final bool showCelebration = !isLoadingNow &&
              !showFailure &&
              (state.isSuccess || state.isLevelCompleted);

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
                    if (!showLoading)
                      AppAsset(
                        assetName: themeController.themeMode == ThemeMode.dark
                            ? Assets.splashdark
                            : Assets.splashlight,
                      ),
                    if (!showLoading &&
                        !showFailure &&
                        _runtimeController.controller != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomAppBarRow(
                                  title: widget.title, onBack: _safeExit),
                              SizedBox(height: 16.h),
                              TestLevelWordProgress(
                                cleanWord: _cleanWord,
                                currentIndex: state.currentIndex,
                              ),
                              SizedBox(height: 16.h),
                              TestLevelCameraBox(
                                state: state,
                                cleanWord: _cleanWord,
                                controller: _runtimeController.controller!,
                                isCameraInitialized:
                                    _runtimeController.isCameraInitialized,
                                isFlashOn: _runtimeController.isFlashOn,
                                onToggleFlash: _toggleFlash,
                              ),
                              SizedBox(height: 20.h),
                              TestLevelStatusBox(state: state),
                              SizedBox(height: 20.h),
                              TestLevelTipsSection(isDarkMode: isDarkMode),
                              SizedBox(height: 16.h),
                              AppButton(
                                text:
                                    state.isLevelCompleted ? 'Finish' : 'Back',
                                onPressed: _safeExit,
                                textColor:
                                    themeController.themeMode == ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                color: state.isLevelCompleted
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
                    if (showLoading)
                      TestLevelLoadingOverlay(isDarkMode: isDarkMode),
                    if (showFailure)
                      TestLevelFailureOverlay(
                        message: state.errorMessage ?? 'Unexpected error',
                        onRetry: _retryInitialization,
                        isDarkMode: isDarkMode,
                      ),
                    if (showCelebration)
                      TestLevelCelebrationOverlay(
                        burstMode: state.isLevelCompleted,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
