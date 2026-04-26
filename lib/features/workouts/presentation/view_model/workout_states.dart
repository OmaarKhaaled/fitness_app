import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/muscle.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/muscles_group.dart';

class WorkoutStates extends BaseState<void> {
  final List<MusclesGroup> muscleGroups;
  final bool isMuscleGroupsLoading;

  final String? selectedMuscleGroupId;
  final String selectedMuscleGroupName;

  final List<Muscle> muscles;
  final bool isMusclesLoading;

  WorkoutStates({
    super.isLoading = false,
    super.errorMessage,
    this.muscleGroups = const [],
    this.isMuscleGroupsLoading = false,
    this.selectedMuscleGroupId,
    String? selectedMuscleGroupName,
    this.muscles = const [],
    this.isMusclesLoading = false,
  }) : selectedMuscleGroupName =
           selectedMuscleGroupName ?? AppTextConstants.workoutsAll;

  @override
  WorkoutStates copyWith({
    void data,
    bool? isLoading,
    String? errorMessage,
    List<MusclesGroup>? muscleGroups,
    bool? isMuscleGroupsLoading,
    String? selectedMuscleGroupId,
    String? selectedMuscleGroupName,
    List<Muscle>? muscles,
    bool? isMusclesLoading,
  }) {
    return WorkoutStates(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      muscleGroups: muscleGroups ?? this.muscleGroups,
      isMuscleGroupsLoading:
          isMuscleGroupsLoading ?? this.isMuscleGroupsLoading,
      selectedMuscleGroupId:
          selectedMuscleGroupId ?? this.selectedMuscleGroupId,
      selectedMuscleGroupName:
          selectedMuscleGroupName ?? this.selectedMuscleGroupName,
      muscles: muscles ?? this.muscles,
      isMusclesLoading: isMusclesLoading ?? this.isMusclesLoading,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    muscleGroups,
    isMuscleGroupsLoading,
    selectedMuscleGroupId,
    selectedMuscleGroupName,
    muscles,
    isMusclesLoading,
  ];
}
