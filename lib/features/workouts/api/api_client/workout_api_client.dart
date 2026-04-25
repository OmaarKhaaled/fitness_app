import 'package:dio/dio.dart';
import 'package:fitness_app/core/constants/api_constants.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/workout_response.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/wourkout_group_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'workout_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class WorkoutApiClient {
  @factoryMethod
  factory WorkoutApiClient(Dio dio) = _WorkoutApiClient;

  @GET(ApiConstants.getAllMuscleGroupsEndpoint)
  Future<WorkoutResponse> getWorkouts();

  @GET(ApiConstants.getAllMuscleGroupByMuscleIdEndpoint)
  Future<WourkoutGroupResponse> getWorkoutsByMuscleGroupId(
    @Path('MuscleGroupId') String muscleGroupId,
  );

  @GET(ApiConstants.getRandomMuscleEndpoint)
  Future<PrimeMoverMuscleResponse> get20randomPrimeMoverMuscle();

  @GET(ApiConstants.getMuscleGroupByMuscleIdEndpoint)
  Future<PrimeMoverMuscleResponse> getAllPrimeMoverMusclebyMuscleGroupId(
    @Query('muscleGroupId') String muscleGroupId,
  );
}
