sealed class ExerciseIntent {
  const ExerciseIntent();
}

class LoadLevels extends ExerciseIntent {
  final String token;
  final String muscleId;
  const LoadLevels({required this.token, required this.muscleId});
}

class SelectLevel extends ExerciseIntent {
  final int index;
  const SelectLevel(this.index);
}
