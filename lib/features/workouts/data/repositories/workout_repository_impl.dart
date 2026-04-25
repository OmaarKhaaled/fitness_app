import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/data/data_sources/wourkout_data_source.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/workout_response.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/wourkout_group_response.dart';
import 'package:fitness_app/features/workouts/domain/repositories/workout_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkoutRepository)
class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutDataSource _dataSource;

  WorkoutRepositoryImpl(this._dataSource);

  @override
  Future<BaseResponse<WorkoutResponse>> getWorkouts() async {
    final result = await _dataSource.getWorkouts();
    return result.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (data) => BaseResponse.success(data),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }

  @override
  Future<BaseResponse<WourkoutGroupResponse>> getWorkoutsByMuscleGroupId(
    String muscleGroupId,
  ) async {
    final result = await _dataSource.getWorkoutsByMuscleGroupId(muscleGroupId);
    return result.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (data) => BaseResponse.success(data),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }

  @override
  Future<BaseResponse<PrimeMoverMuscleResponse>>
  get20randomPrimeMoverMuscle() async {
    final result = await _dataSource.get20randomPrimeMoverMuscle();
    return result.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (data) => BaseResponse.success(data),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }

  @override
  Future<BaseResponse<PrimeMoverMuscleResponse>>
  getAllPrimeMoverMusclebyMuscleGroupId(String muscleGroupId) async {
    final result = await _dataSource.getAllPrimeMoverMusclebyMuscleGroupId(
      muscleGroupId,
    );
    return result.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (data) => BaseResponse.success(data),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }
}
