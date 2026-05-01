import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';

sealed class ExerciseIntent {
  const ExerciseIntent();
}

class LoadLevels extends ExerciseIntent {
  final ExerciseModel exercise;
  const LoadLevels(this.exercise);
}

class SelectLevel extends ExerciseIntent {
  final int index;
  const SelectLevel(this.index);
}
