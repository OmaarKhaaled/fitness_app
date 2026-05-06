import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/workout_response.dart';
import 'package:fitness_app/features/workouts/domain/repositories/workout_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWorkoutsUseCase {
  final WorkoutRepository _repository;

  GetWorkoutsUseCase(this._repository);

  Future<BaseResponse<WorkoutResponse>> call() {
    return _repository.getWorkouts();
  }
}
