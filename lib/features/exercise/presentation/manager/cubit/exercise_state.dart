import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';

class ExerciseState extends Equatable {
  final bool isLevelsLoading;
  final bool isExercisesLoading;
  final List<LevelModel> levels;
  final List<ExerciseModel> exercises;
  final int selectedLevelIndex;
  final String? levelsError;
  final String? exercisesError;

  const ExerciseState({
    this.isLevelsLoading = false,
    this.isExercisesLoading = false,
    this.levels = const [],
    this.exercises = const [],
    this.selectedLevelIndex = 0,
    this.levelsError,
    this.exercisesError,
  });

  ExerciseState copyWith({
    bool? isLevelsLoading,
    bool? isExercisesLoading,
    List<LevelModel>? levels,
    List<ExerciseModel>? exercises,
    int? selectedLevelIndex,
    String? levelsError,
    String? exercisesError,
  }) {
    return ExerciseState(
      isLevelsLoading: isLevelsLoading ?? this.isLevelsLoading,
      isExercisesLoading: isExercisesLoading ?? this.isExercisesLoading,
      levels: levels ?? this.levels,
      exercises: exercises ?? this.exercises,
      selectedLevelIndex: selectedLevelIndex ?? this.selectedLevelIndex,
      levelsError: levelsError,
      exercisesError: exercisesError,
    );
  }

  @override
  List<Object?> get props => [
    isLevelsLoading,
    isExercisesLoading,
    levels,
    exercises,
    selectedLevelIndex,
    levelsError,
    exercisesError,
  ];
}