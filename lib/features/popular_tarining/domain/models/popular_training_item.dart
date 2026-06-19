import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/muscle.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';

class PopularTrainingItem {
  final Muscle muscle;
  final List<LevelModel> levels;
  final int exerciseCount;
  final String displayLevel;

  const PopularTrainingItem({
    required this.muscle,
    required this.levels,
    required this.exerciseCount,
    required this.displayLevel,
  });
}
