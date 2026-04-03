import 'package:isharaapp/features/home/data/repositories/test/test_repository_impl.dart';
import 'package:isharaapp/features/home/data/services/test/test_api_service.dart';
import 'package:isharaapp/features/home/domain/usecases/test/complete_test_word_use_case.dart';
import 'package:isharaapp/features/home/domain/usecases/test/get_test_levels_use_case.dart';
import 'package:isharaapp/features/home/presentation/cubit/test_api_cubit.dart';

class TestDi {
  static TestApiCubit createCubit() {
    final apiService = TestApiService();
    final repository = TestRepositoryImpl(testApiService: apiService);

    return TestApiCubit(
      getTestLevelsUseCase: GetTestLevelsUseCase(repository),
      completeTestWordUseCase: CompleteTestWordUseCase(repository),
    );
  }
}
