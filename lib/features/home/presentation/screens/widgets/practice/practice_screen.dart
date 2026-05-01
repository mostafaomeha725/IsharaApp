import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/core/di/practice_di.dart';
import 'package:isharaapp/features/home/presentation/cubit/practice_cubit.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/home_appbar.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/custom_nav_bar.dart';

import 'practice_screen_body.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  int? _selectedLevelIndex;
  late final PracticeCubit _practiceCubit;

  @override
  void initState() {
    super.initState();
    _practiceCubit = PracticeDi.createCubit()..loadLevels();
  }

  @override
  void dispose() {
    _practiceCubit.close();
    super.dispose();
  }

  void _goBackOneStep() {
    setState(() {
      if (_selectedLevelIndex != null) {
        _selectedLevelIndex = null;
      } else {
        final navBarState = CustomNavBar.of(context);
        navBarState?.onWillPop();
      }
    });
  }

  void _onSelectLevel(int index) {
    setState(() {
      _selectedLevelIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _practiceCubit,
      child: BlocConsumer<PracticeCubit, PracticeState>(
        listener: (context, state) {
          if (state.message == null || state.message!.isEmpty) {
            return;
          }

          if (state.status == PracticeStatus.error ||
              state.action == PracticeAction.completeLesson) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: _selectedLevelIndex != null
                ? null
                : AppBar(
                    automaticallyImplyLeading: false,
                    title:
                        HomeAppbar(title: 'Practice', onBack: _goBackOneStep),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
            body: PracticeScreenBody(
              selectedLevelIndex: _selectedLevelIndex,
              state: state,
              onGoBackOneStep: _goBackOneStep,
              onSelect: _onSelectLevel,
            ),
          );
        },
      ),
    );
  }
}
