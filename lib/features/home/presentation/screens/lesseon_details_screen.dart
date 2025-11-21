import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_button.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/words_details.dart';
import 'package:url_launcher/url_launcher.dart';

class LesseonDetailsScreen extends StatelessWidget {
  const LesseonDetailsScreen({
    super.key,
    required this.onBack,
    required this.letter,
    this.onNext,
  });

  final VoidCallback onBack;
  final VoidCallback? onNext;
  final String letter;

  Future<void> _openYoutubeVideo(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    final bool isDark = themeController.themeMode == ThemeMode.dark;

    final Color mainColor = isDark ? Colors.white : Colors.black;
    final Color secondaryColor = isDark ? Colors.white70 : Colors.black87;
    final Color overlayColor =
        // ignore: deprecated_member_use
        isDark ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.3);
    final Color buttonBg = isDark ? Colors.white : Colors.black;
    final Color buttonText = isDark ? Colors.black : Colors.white;

    final String singleLetter = letter.split(' ').last;
    final data = lessonsData[singleLetter] ??
        {
          'title': letter,
          'steps': 'No data available for this letter.',
          'mistakes': '',
        };

    const String videoUrl = 'https://youtu.be/eEmXHJX7Wb0?si=UJctxW12nos8B352';
    const String videoId = 'eEmXHJX7Wb0';
    const String thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 52.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppAsset(assetName: Assets.boyandgirlworkoncomputer),
                  AppAsset(assetName: Assets.onlinemeating),
                ],
              ),
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () => _openYoutubeVideo(videoUrl),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        thumbnailUrl,
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200.h,
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200.h,
                          color: isDark ? Colors.grey[800] : Colors.grey[300],
                          alignment: Alignment.center,
                          child: Icon(Icons.broken_image, color: mainColor),
                        ),
                      ),
                    ),
                    Container(
                      height: 60.w,
                      width: 60.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: overlayColor,
                        border: Border.all(color: mainColor, width: 3),
                      ),
                      child: Icon(Icons.play_arrow, color: mainColor, size: 40),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'KEY STEPS:',
                  style: font20w700.copyWith(color: mainColor),
                ),
              ),
              SizedBox(height: 8.h),
              AppText(
                data['steps']!,
                style: font16w700.copyWith(color: secondaryColor),
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: 40.h),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'COMMON MISTAKES:',
                  style: font20w700.copyWith(color: mainColor),
                ),
              ),
              SizedBox(height: 8.h),
              AppText(
                data['mistakes']!,
                style: font16w700.copyWith(color: secondaryColor),
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: 32.h),
              AppText(
                'Try practicing along with the video!',
                style: font20w700.copyWith(color: mainColor),
                alignment: AlignmentDirectional.center,
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: AppButton(
                      text: 'Go Back',
                      onPressed: onBack,
                      height: 42.h,
                      borderColor: buttonBg,
                      color: buttonBg,
                      textColor: buttonText,
                      textSize: 15.sp,
                      textWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 10,
                    child: AppButton(
                      text: 'Next Letter',
                      onPressed: onNext,
                      height: 42.h,
                      color: buttonBg,
                      textColor: buttonText,
                      textSize: 15.sp,
                      textWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
