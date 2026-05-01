import 'package:fitness_app/features/workouts/api/api_client/workout_api_client.dart';
import 'package:fitness_app/features/workouts/data/data_sources/wourkout_data_source.dart';
import 'package:fitness_app/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_workouts_use_case.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_workouts_by_muscle_group_id_use_case.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_random_prime_mover_muscle_use_case.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_all_prime_mover_muscle_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  WorkoutApiClient,
  WorkoutDataSource,
  WorkoutRepository,
  GetWorkoutsUseCase,
  GetWorkoutsByMuscleGroupIdUseCase,
  GetRandom20PrimeMoverMuscleUseCase,
  GetAllPrimeMoverMuscleUseCase,
])
void main() {}
