import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/repo/exercise_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetExercisesByPrimaryMuscleAndLevelUseCase {
  final ExerciseRepo repo;

  GetExercisesByPrimaryMuscleAndLevelUseCase(this.repo);

  Future<BaseResponse<List<ExerciseModel>>> call(
    String primaryMuscle,
    String level,
  ) async {
    final result = await repo.getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
      primaryMuscle,
      level,
    );
    return result;
  }
}
