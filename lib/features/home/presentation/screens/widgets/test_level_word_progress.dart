import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

class TestLevelWordProgress extends StatelessWidget {
  const TestLevelWordProgress({
    super.key,
    required this.cleanWord,
    required this.currentIndex,
  });

  final String cleanWord;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(cleanWord.length, (index) {
              final bool isCompleted = index < currentIndex;
              final bool isCurrent = index == currentIndex;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green
                        : (isCurrent
                            ? Colors.orange
                            : Colors.grey.withOpacity(0.2)),
                    shape: BoxShape.circle,
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.6),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ]
                        : [],
                    border: isCurrent
                        ? Border.all(color: Colors.white, width: 2)
                        : null,
                  ),
                  child: AppText(
                    cleanWord[index],
                    style: font24w800.copyWith(
                      color:
                          isCompleted || isCurrent ? Colors.white : Colors.grey,
                    ),
                    alignment: AlignmentDirectional.center,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
