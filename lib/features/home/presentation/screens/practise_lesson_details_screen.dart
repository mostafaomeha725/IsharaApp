import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/routes/route_paths.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_runtime_helpers.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/test_level_template.dart';

class PractiseLessonDetailsScreen extends StatelessWidget {
  final String title;
  final List<String> words;
  final CameraDescription camera;
  final int? completionId;
  final String? completionType;
  final Future<void> Function(int itemId)? onComplete;

  const PractiseLessonDetailsScreen({
    super.key,
    required this.title,
    required this.words,
    required this.camera,
    this.completionId,
    this.completionType,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    unawaited(prewarmTestLevelModel());

    final cleanedWords = words
        .map((word) => word.trim())
        .where((word) => word.isNotEmpty)
        .toList();

    if (cleanedWords.length <= 1) {
      final String singleWord =
          cleanedWords.isNotEmpty ? cleanedWords.first : title.split(' ').last;

      return TestLevelTemplate(
        title: title,
        word: singleWord,
        onBackPressed: () => GoRouter.of(context).pop(),
        camera: camera,
        completionId: completionId,
        completionType: completionType,
        onComplete: onComplete,
      );
    }

    final themeController = ThemeController.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AppAsset(
              assetName: themeController.themeMode == ThemeMode.dark
                  ? Assets.splashdark
                  : Assets.splashlight,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Expanded(
                        child: AppText(
                          '$title Words',
                          textAlign: TextAlign.center,
                          style: font20w700,
                          alignment: AlignmentDirectional.center,
                        ),
                      ),
                      SizedBox(width: 48.w),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  AppText(
                    'Choose a word to start testing',
                    style: font16w700,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: cleanedWords.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final word = cleanedWords[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: () async {
                            await prewarmTestLevelModel();
                            if (!context.mounted) {
                              return;
                            }

                            context.push(
                              Routes.practisedetails,
                              extra: {
                                'title': '$title - ${word.toUpperCase()}',
                                'words': [word],
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 14.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.7),
                              border: Border.all(
                                color: ThemeController.of(context).themeMode ==
                                        ThemeMode.dark
                                    ? Colors.white24
                                    : Colors.black12,
                              ),
                            ),
                            child: Row(
                              children: [
                                AppText(
                                  '${index + 1}.',
                                  style: font16w700,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: AppText(
                                    word,
                                    style: font18w700,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                const Icon(Icons.play_arrow_rounded),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
