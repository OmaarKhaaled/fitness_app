import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/workout_response.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/wourkout_group_response.dart';

abstract class WorkoutDataSource {
  Future<BaseResponse<WorkoutResponse>> getWorkouts();

  Future<BaseResponse<WourkoutGroupResponse>> getWorkoutsByMuscleGroupId(
    String muscleGroupId,
  );
  Future<BaseResponse<PrimeMoverMuscleResponse>> get20randomPrimeMoverMuscle();
  Future<BaseResponse<PrimeMoverMuscleResponse>>
  getAllPrimeMoverMusclebyMuscleGroupId(String muscleGroupId);
}
