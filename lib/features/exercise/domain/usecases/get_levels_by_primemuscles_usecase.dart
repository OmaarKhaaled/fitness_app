import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:fitness_app/features/exercise/domain/repo/exercise_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetLevelsByPrimemusclesUsecase {
  final ExerciseRepo exerciseRepo;

  GetLevelsByPrimemusclesUsecase(this.exerciseRepo);

  Future<BaseResponse<List<LevelModel>>> call(
    String token,
    String muscleId,
  ) async {
    final result = await exerciseRepo.getDifficultyLevelsByPrimeMoverMuscle(
      token,
      muscleId,
    );
    return result;
  }
}
