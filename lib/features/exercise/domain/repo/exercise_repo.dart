import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';

abstract class ExerciseRepo {
  Future<BaseResponse<List<LevelModel>>> getDifficultyLevelsByPrimeMoverMuscle(
    String token,
    String primeMoverMuscleId,
  );
  Future<BaseResponse<List<ExerciseModel>>>
  getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  );
}
