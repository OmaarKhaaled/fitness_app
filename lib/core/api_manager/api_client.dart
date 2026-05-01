import 'package:dio/dio.dart';
import 'package:fitness_app/core/constants/api_constants.dart';
import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/login/data/models/response/login_response.dart';
import 'package:fitness_app/features/exercise/data/models/response/exercise_response.dart';
import 'package:fitness_app/features/exercise/data/models/response/levels_by_primemuscle_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
@singleton
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(ApiConstants.loginEndpoint)
  Future<LoginResponse> login(@Body() LoginRequest request);

  @GET(ApiConstants.getAllDifficultyLevels)
  Future<List<String>> getAllDifficultyLevels();

  @GET(ApiConstants.getRandomPrimeMoverMusclesEndpoint)
  Future<List<String>> getRandomPrimeMoverMuscles();

  @GET(ApiConstants.getDifficultyLevelsByPrimeMoverEndpoint)
  Future<LevelsByPrimemuscleResponse> getDifficultyLevelsByPrimeMoverMuscle(
    @Header('Authorization') String token,
    @Query('primeMoverMuscleId') String primeMoverMuscleId,
  );

  @GET(ApiConstants.exercisesByPrimeMoverMuscleAndDifficultyLevel)
  Future<ExerciseResponse> getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
    @Query('primeMoverMuscleId') String primeMoverMuscleId,
    @Query('difficultyLevelId') String difficultyLevelId,
  );
}
