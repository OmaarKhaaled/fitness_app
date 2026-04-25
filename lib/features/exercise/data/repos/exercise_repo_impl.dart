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
    String token,
    String primeMoverMuscleId,
  ) async {
    try {
      final result = await exerciseRemoteDataSource
          .getAllDifficultyLevelsByPrimeMoverMuscle(token, primeMoverMuscleId);

      final levels = result
          .expand((response) => response.difficultyLevels ?? [])
          .map(
            (d) => LevelModel(
              id: d.id ?? '',
              name: d.name ?? '',
            ),
          )
          .toList();

      return SuccessApiResult(data: levels);
    } catch (e) {
      return ErrorApiResult(error: e.toString());
    }
  }

  @override
  Future<ApiResult<List<ExerciseModel>>>
  getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  ) async {
    try {
      final result = await exerciseRemoteDataSource
          .getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
            primeMoverMuscleId,
            difficultyLevelId,
          );

      final exercises = result
          .expand((response) => response.exercises ?? [])
          .map(
            (e) => ExerciseModel(
              id: e.id ?? '',
              name: e.exercise ?? '',
              difficultyLevel: e.difficultyLevel,
              targetMuscleGroup: e.targetMuscleGroup,
              primeMoverMuscle: e.primeMoverMuscle,
              primaryEquipment: e.primaryEquipment,
              mechanics: e.mechanics,
              posture: e.posture,
              movementPattern1: e.movementPattern1,
              bodyRegion: e.bodyRegion,
              forceType: e.forceType,
              shortYoutubeDemonstrationLink: e.shortYoutubeDemonstrationLink,
              inDepthYoutubeExplanationLink: e.inDepthYoutubeExplanationLink,
            ),
          )
          .toList();

      return SuccessApiResult(data: exercises);
    } catch (e) {
      return ErrorApiResult(error: e.toString());
    }
  }
}
