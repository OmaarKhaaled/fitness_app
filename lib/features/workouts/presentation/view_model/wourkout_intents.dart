sealed class WorkoutIntents {}

class LoadInitialDataIntent extends WorkoutIntents {}

class SelectMuscleGroupIntent extends WorkoutIntents {
  final String? muscleGroupId;
  final String muscleGroupName;
  SelectMuscleGroupIntent({
    required this.muscleGroupId,
    required this.muscleGroupName,
  });
}

class RefreshWorkoutsIntent extends WorkoutIntents {}
