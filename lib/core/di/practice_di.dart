import 'package:isharaapp/features/home/data/repositories/practice/practice_repository_impl.dart';
import 'package:isharaapp/features/home/data/services/practice/practice_api_service.dart';
import 'package:isharaapp/features/home/domain/usecases/practice/complete_practice_lesson_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/practice/get_practice_levels_use_case.dart';
import 'package:isharaapp/features/home/presentation/cubit/practice_cubit.dart';

class PracticeDi {
  static PracticeCubit createCubit() {
    final apiService = PracticeApiService();
    final repository = PracticeRepositoryImpl(practiceApiService: apiService);

    return PracticeCubit(
      getPracticeLevelsUseCase: GetPracticeLevelsUseCase(repository),
      completePracticeLessonUseCase: CompletePracticeLessonUseCase(repository),
    );
  }
}
