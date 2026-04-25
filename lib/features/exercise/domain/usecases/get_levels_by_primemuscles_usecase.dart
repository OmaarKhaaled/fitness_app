import 'package:fitness_app/config/network/api_result.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:fitness_app/features/exercise/domain/repo/exercise_repo.dart';

class GetLevelsByPrimemusclesUsecase {
  final ExerciseRepo exerciseRepo;

  GetLevelsByPrimemusclesUsecase(this.exerciseRepo);

  Future<ApiResult<List<LevelModel>>> call(String token, String primeMoverMuscleId) async {
    final result = await exerciseRepo.getDifficultyLevelsByPrimeMoverMuscle(
      token,
      primeMoverMuscleId,
    );
    return result;
  }
}
