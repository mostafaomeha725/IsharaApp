import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/cubit/test_level_state.dart';

class TestLevelCameraBox extends StatelessWidget {
  const TestLevelCameraBox({
    super.key,
    required this.state,
    required this.cleanWord,
    required this.controller,
    required this.isCameraInitialized,
    required this.isFlashOn,
    required this.onToggleFlash,
  });

  final TestLevelState state;
  final String cleanWord;
  final CameraController controller;
  final bool isCameraInitialized;
  final bool isFlashOn;
  final VoidCallback onToggleFlash;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: state.isSuccess ? Colors.green : Colors.grey.withOpacity(0.5),
          width: state.isSuccess ? 4 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isCameraInitialized)
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CameraPreview(controller),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            if (isCameraInitialized)
              Positioned(
                top: 10.h,
                right: 10.w,
                child: IconButton(
                  onPressed: onToggleFlash,
                  icon: Icon(
                    isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                  style: IconButton.styleFrom(backgroundColor: Colors.black38),
                ),
              ),
            if (!state.isLevelCompleted &&
                state.currentIndex < cleanWord.length)
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
                  child: AppText(
                    'Target: ${cleanWord[state.currentIndex]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
