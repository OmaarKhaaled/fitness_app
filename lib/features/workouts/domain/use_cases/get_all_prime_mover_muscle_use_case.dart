import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/workouts/domain/repositories/workout_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllPrimeMoverMuscleUseCase {
  final WorkoutRepository _workoutRepository;
  GetAllPrimeMoverMuscleUseCase(this._workoutRepository);

  Future<BaseResponse<PrimeMoverMuscleResponse>> call(String muscleGroupId) {
    return _workoutRepository.getAllPrimeMoverMusclebyMuscleGroupId(
      muscleGroupId,
    );
  }
}
