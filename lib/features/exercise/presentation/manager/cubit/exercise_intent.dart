sealed class ExerciseIntent {
  const ExerciseIntent();
}

class LoadLevels extends ExerciseIntent {
  final String muscleId;
  const LoadLevels({required this.muscleId});
}

class SelectLevel extends ExerciseIntent {
  final int index;
  const SelectLevel(this.index);
}
