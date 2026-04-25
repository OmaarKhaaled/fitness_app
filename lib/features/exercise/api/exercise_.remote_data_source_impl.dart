import 'package:fitness_app/core/api_manager/api_client.dart';
import 'package:fitness_app/features/exercise/data/datasource/exercise_.remote_data_source.dart';
import 'package:fitness_app/features/exercise/data/models/response/exercise_response.dart';
import 'package:fitness_app/features/exercise/data/models/response/levels_by_primemuscle_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExerciseRemoteDataSource)
class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final ApiClient apiClient;

  ExerciseRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<LevelsByPrimemuscleResponse>>
  getAllDifficultyLevelsByPrimeMoverMuscle(String token ,String primeMoverMuscleId) {
    final levelsRequest = apiClient.getDifficultyLevelsByPrimeMoverMuscle(
      token,
      primeMoverMuscleId,
    );
    return levelsRequest;
  }

  @override
  Future<List<ExerciseResponse>>
  getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  ) {
    final exerciseRequest = apiClient
        .getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
          primeMoverMuscleId,
          difficultyLevelId,
        );
    return exerciseRequest;
  }
}