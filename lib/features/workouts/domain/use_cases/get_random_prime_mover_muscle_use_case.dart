import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/workouts/domain/repositories/workout_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRandom20PrimeMoverMuscleUseCase {
  final WorkoutRepository _repository;

  GetRandom20PrimeMoverMuscleUseCase(this._repository);

  Future<BaseResponse<PrimeMoverMuscleResponse>> call() {
    return _repository.get20randomPrimeMoverMuscle();
  }
}
