import 'package:isharaapp/features/home/data/repositories/learn_repository_impl.dart';
import 'package:isharaapp/features/home/data/services/learn_api_service.dart';
import 'package:isharaapp/features/home/domain/usecases/complete_lesson_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/get_learn_levels_use_case.dart';
import 'package:isharaapp/features/home/presentation/cubit/learn_cubit.dart';

class LearnDi {
  static LearnCubit createCubit() {
    final apiService = LearnApiService();
    final repository = LearnRepositoryImpl(learnApiService: apiService);

    return LearnCubit(
      getLearnLevelsUseCase: GetLearnLevelsUseCase(repository),
      completeLessonUseCase: CompleteLessonUseCase(repository),
    );
  }
}
