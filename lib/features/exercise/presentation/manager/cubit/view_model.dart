import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';

class ExerciseSectionViewModel {
  final String title;
  final LevelModel level;
  final String muscleName;
  final List<ExerciseModel> exercises;

  ExerciseSectionViewModel({
    required this.title,
    required this.level,
    required this.muscleName,
    required this.exercises,
  });
}
