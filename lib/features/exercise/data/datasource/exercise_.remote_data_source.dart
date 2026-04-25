import 'package:fitness_app/features/exercise/data/models/response/exercise_response.dart';
import 'package:fitness_app/features/exercise/data/models/response/levels_by_primemuscle_response.dart';

abstract class ExerciseRemoteDataSource {
  Future<List<LevelsByPrimemuscleResponse>>
  getAllDifficultyLevelsByPrimeMoverMuscle(
    String token,
    String primeMoverMuscleId,
  );

  Future<List<ExerciseResponse>>
  getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  );
}
