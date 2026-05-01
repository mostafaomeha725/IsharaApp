import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/constants/app_assets.dart';
import 'package:isharaapp/core/widgets/app_asset.dart';
import 'package:isharaapp/features/home/presentation/cubit/learn_cubit.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';

import 'learn_api_cards.dart';
import 'learn_fallback_cards.dart';

class LearnLevelsHome extends StatelessWidget {
  final LearnState state;
  final void Function(int) onGoTo;

  const LearnLevelsHome({
    super.key,
    required this.state,
    required this.onGoTo,
  });

  @override
  Widget build(BuildContext context) {
    final levels = state.levels;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 76.h),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: AppAsset(assetName: Assets.boyandgirlworkoncomputer),
                ),
                SizedBox(height: 32.h),
                if (state.status == LearnStatus.loading && levels.isEmpty)
                  const Center(child: CircularProgressIndicator())
                else if (levels.isEmpty)
                  LearnFallbackCards(onGoTo: onGoTo)
                else
                  LearnApiCards(levels: levels, onGoTo: onGoTo),
                if (state.status == LearnStatus.error)
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: TextButton.icon(
                      onPressed: () {
                        context
                            .read<LearnCubit>()
                            .loadLevels(forceLoading: true);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry loading levels'),
                    ),
                  ),
                SizedBox(height: 36.h),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: HomeAppbar(title: 'Learn'),
        ),
      ],
    );
  }
}
