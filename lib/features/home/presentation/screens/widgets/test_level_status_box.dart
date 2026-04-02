import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/cubit/test_level_state.dart';

class TestLevelStatusBox extends StatelessWidget {
  const TestLevelStatusBox({
    super.key,
    required this.state,
  });

  final TestLevelState state;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: state.isSuccess || state.isLevelCompleted ? 1.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
        decoration: BoxDecoration(
          color: state.isLevelCompleted
              ? Colors.blue
              : (state.statusColor == Colors.green
                  ? Colors.green
                  : state.statusColor == Colors.orange
                      ? Colors.orangeAccent
                      : state.statusColor == Colors.red
                          ? Colors.redAccent
                          : Colors.blueAccent),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: state.isSuccess
                  ? Colors.green.withOpacity(0.5)
                  : Colors.black26,
              blurRadius: state.isSuccess ? 15 : 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              state.isLevelCompleted
                  ? Icons.star
                  : (state.isSuccess ? Icons.check_circle : Icons.camera),
              color: Colors.white,
              size: 24.sp,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: AppText(
                state.statusMessage,
                style: font18w700.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
