import 'package:fitness_app/features/exercise/domain/models/muscle_model.dart';

sealed class ExerciseIntent {
  const ExerciseIntent();
}

class LoadLevels extends ExerciseIntent {
  final MuscleModel muscle;
  const LoadLevels({required this.muscle});
}

class SelectLevel extends ExerciseIntent {
  final int index;
  const SelectLevel(this.index);
}
