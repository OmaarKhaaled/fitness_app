import 'package:fitness_app/config/network/api_result.dart';
import 'package:fitness_app/features/exercise/data/datasource/exercise_.remote_data_source.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:fitness_app/features/exercise/domain/repo/exercise_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseRemoteDataSource exerciseRemoteDataSource;
  ExerciseRepoImpl(this.exerciseRemoteDataSource);

  @override
  Future<ApiResult<List<LevelModel>>> getDifficultyLevelsByPrimeMoverMuscle(
    String primeMoverMuscleId,
  ) async {
    final result = await exerciseRemoteDataSource
        .getAllDifficultyLevelsByPrimeMoverMuscle(primeMoverMuscleId);
    return SuccessApiResult(data:   result.map((e) => LevelModel()).toList());
  }

  @override
  Future<ApiResult<List<ExerciseModel>>> getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  ) async {
    final result = await exerciseRemoteDataSource
        .getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
          primeMoverMuscleId,
          difficultyLevelId,
        );
    return SuccessApiResult(data: result.map((e) => ExerciseModel()).toList());
  }
}
