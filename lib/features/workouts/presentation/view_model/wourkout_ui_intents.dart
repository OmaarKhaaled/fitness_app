class WorkoutUiIntents {
  WorkoutUiIntents();
}

class ShowErrorWorkoutIntent extends WorkoutUiIntents {
  final String error;
  ShowErrorWorkoutIntent({required this.error});
}
