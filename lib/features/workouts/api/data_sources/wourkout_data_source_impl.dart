import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/features/workouts/api/api_client/workout_api_client.dart';
import 'package:fitness_app/features/workouts/data/data_sources/wourkout_data_source.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/workout_response.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/wourkout_group_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkoutDataSource)
class WorkoutDataSourceImpl implements WorkoutDataSource {
  final WorkoutApiClient _apiClient;

  WorkoutDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<WorkoutResponse>> getWorkouts() {
    return apiCall(() async {
      return await _apiClient.getWorkouts();
    });
  }

  @override
  Future<BaseResponse<WourkoutGroupResponse>> getWorkoutsByMuscleGroupId(
    String muscleGroupId,
  ) {
    return apiCall(() async {
      return await _apiClient.getWorkoutsByMuscleGroupId(muscleGroupId);
    });
  }

  @override
  Future<BaseResponse<PrimeMoverMuscleResponse>> get20randomPrimeMoverMuscle() {
    return apiCall(() async {
      return await _apiClient.get20randomPrimeMoverMuscle();
    });
  }

  @override
  Future<BaseResponse<PrimeMoverMuscleResponse>>
  getAllPrimeMoverMusclebyMuscleGroupId(String muscleGroupId) {
    return apiCall(() async {
      return await _apiClient.getAllPrimeMoverMusclebyMuscleGroupId(
        muscleGroupId,
      );
    });
  }
}
