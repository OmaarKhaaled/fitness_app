import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/wourkout_group_response.dart';
import 'package:fitness_app/features/workouts/domain/repositories/workout_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWorkoutsByMuscleGroupIdUseCase {
  final WorkoutRepository _repository;

  GetWorkoutsByMuscleGroupIdUseCase(this._repository);

  Future<BaseResponse<WourkoutGroupResponse>> call(String muscleGroupId) {
    return _repository.getWorkoutsByMuscleGroupId(muscleGroupId);
  }
}
