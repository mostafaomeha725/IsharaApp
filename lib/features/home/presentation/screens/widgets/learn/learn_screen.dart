import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isharaapp/features/home/presentation/cubit/learn_cubit.dart';
import 'package:isharaapp/features/home/presentation/cubit/practice_cubit.dart';
import 'package:isharaapp/core/di/learn_di.dart';
import 'package:isharaapp/core/di/practice_di.dart';

import 'learn_screen_body.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  int _currentIndex = 0;
  late final LearnCubit _learnCubit;
  late final PracticeCubit _practiceCubit;

  @override
  void initState() {
    super.initState();
    _learnCubit = LearnDi.createCubit()..loadLevels();
    _practiceCubit = PracticeDi.createCubit()..loadLevels();
  }

  @override
  void dispose() {
    _learnCubit.close();
    _practiceCubit.close();
    super.dispose();
  }

  Future<void> _completePracticeForLetter(String letter) async {
    final practiceState = _practiceCubit.state;
    for (final level in practiceState.levels) {
      for (final lesson in level.lessons) {
        final label =
            lesson.title.trim().split(RegExp(r'\s+')).last.toUpperCase();
        if (label == letter.toUpperCase() && !lesson.isCompleted) {
          await _practiceCubit.completeLesson(lesson.id);
          return;
        }
      }
    }
  }

  void _goTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _goBack() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _learnCubit,
      child: BlocConsumer<LearnCubit, LearnState>(
        listener: (context, state) {
          final message = state.message;
          if (message == null || message.isEmpty) {
            return;
          }

          if (state.status == LearnStatus.error ||
              state.action == LearnAction.completeLesson) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: LearnScreenBody(
              currentIndex: _currentIndex,
              state: state,
              onGoBack: _goBack,
              onGoTo: _goTo,
              onCompletePracticeForLetter: _completePracticeForLetter,
            ),
          );
        },
      ),
    );
  }
}
