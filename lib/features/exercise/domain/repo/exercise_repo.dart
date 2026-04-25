
import 'package:fitness_app/config/network/api_result.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';

abstract class ExerciseRepo {
  Future<ApiResult<List<LevelModel>>> getDifficultyLevelsByPrimeMoverMuscle(
    String primeMoverMuscleId,
  );
  Future<ApiResult<List<ExerciseModel>>> getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  );
}