import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LesseonDetailsScreen extends StatefulWidget {
  const LesseonDetailsScreen({
    super.key,
    required this.onBack,
    required this.letter,
  });

  final VoidCallback onBack;
  final String letter;

  @override
  State<LesseonDetailsScreen> createState() => _LesseonDetailsScreenState();
}

class _LesseonDetailsScreenState extends State<LesseonDetailsScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
              'https://youtu.be/eEmXHJX7Wb0?si=UJctxW12nos8B352')!
          .toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showMiniPlayer() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.4,
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gender = GenderController.of(context).genderTheme;
    final Color mainColor = gender == GenderTheme.boy
        ? const Color(0xFF3A7CF2)
        : const Color(0xFFF24BB6);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              'Letter ( ${widget.letter} )',
              style: font20w700.copyWith(color: Colors.white),
              alignment: AlignmentDirectional.center,
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: _showMiniPlayer,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: false,
                    ),
                  ),
                  Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5),
                      border: Border.all(color: mainColor, width: 3),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: mainColor,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                'KEY STEPS:',
                style: font20w700.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 8.h),
            AppText(
              '1- Make a firm fist with your dominant hand\n'
              '2- Rest your thumb comfortably against your index finger\n'
              '3- Keep your knuckles facing forward',
              style: font16w700.copyWith(color: Colors.white),
            ),
            SizedBox(height: 40.h),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                'COMMON MISTAKES:',
                style: font20w700.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 8.h),
            AppText(
              '✕ Don\'t let your thumb stick straight up\n'
              '✕ Don\'t keep your fingers loose or open',
              style: font16w700.copyWith(color: Colors.white),
            ),
            SizedBox(height: 40.h),
            AppText(
              'Try practicing along with the video!',
              style: font20w700.copyWith(color: Colors.white),
              alignment: AlignmentDirectional.center,
            ),
          ],
        ),
      ),
    );
  }
}
