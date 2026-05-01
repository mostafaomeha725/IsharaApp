import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/theme/styles.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';
import 'package:isharaapp/features/home/presentation/cubit/practice_cubit.dart';

import 'practice_api_cards.dart';
import 'practice_fallback_cards.dart';

class PracticeLevelsHome extends StatelessWidget {
  final PracticeState state;
  final void Function(int) onSelect;

  const PracticeLevelsHome({
    super.key,
    required this.state,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final levels = state.levels;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppAsset(
                assetName: Assets.youngwomanwritingnotebook,
                width: 100.w,
              ),
              SizedBox(width: 16.w),
              Column(
                children: [
                  AppText(
                    'Use your camera to',
                    style: font16w700,
                    alignment: AlignmentDirectional.center,
                  ),
                  AppText(
                    'practice signs.',
                    style: font16w700,
                    alignment: AlignmentDirectional.center,
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              AppAsset(
                assetName:
                    Assets.sideviewofyoungmanwearingsmartwatchandholdingbook,
                width: 80.w,
              ),
            ],
          ),
          SizedBox(height: 38.h),
          if (state.status == PracticeStatus.loading && levels.isEmpty)
            const Center(child: CircularProgressIndicator())
          else if (levels.isEmpty)
            PracticeFallbackCards(onSelect: onSelect)
          else
            PracticeApiCards(levels: levels, onSelect: onSelect),
          if (state.status == PracticeStatus.error)
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: TextButton.icon(
                onPressed: () {
                  context.read<PracticeCubit>().loadLevels(forceLoading: true);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry loading levels'),
              ),
            ),
          SizedBox(height: 38.h),
        ],
      ),
    );
  }
}
