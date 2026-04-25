sealed class WorkoutIntents {
  const WorkoutIntents();
}

class LoadInitialDataIntent extends WorkoutIntents {
  const LoadInitialDataIntent();
}

class SelectMuscleGroupIntent extends WorkoutIntents {
  final String? muscleGroupId;
  final String muscleGroupName;
  const SelectMuscleGroupIntent({
    required this.muscleGroupId,
    required this.muscleGroupName,
  });
}

class RefreshWorkoutsIntent extends WorkoutIntents {
  const RefreshWorkoutsIntent();
}
