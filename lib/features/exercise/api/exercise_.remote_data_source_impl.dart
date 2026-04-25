import 'package:fitness_app/core/api_manager/api_client.dart';
import 'package:fitness_app/features/exercise/data/datasource/exercise_.remote_data_source.dart';
import 'package:fitness_app/features/exercise/data/models/response/exercise_response.dart';
import 'package:fitness_app/features/exercise/data/models/response/levels_by_primemuscle_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExerciseRemoteDataSource)
class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final ApiClient apiClient;

  ExerciseRemoteDataSourceImpl(this.apiClient);

  @override
  Future<LevelsByPrimemuscleResponse> getAllDifficultyLevelsByPrimeMoverMuscle(
    String token,
    String primeMoverMuscleId,
  ) {
    return apiClient.getDifficultyLevelsByPrimeMoverMuscle(
      token,
      primeMoverMuscleId,
    );
  }

  @override
  Future<ExerciseResponse> getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  ) {
    return apiClient.getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
      primeMoverMuscleId,
      difficultyLevelId,
    );
  }
}
