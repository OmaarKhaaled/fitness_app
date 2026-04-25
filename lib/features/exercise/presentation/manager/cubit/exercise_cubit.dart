import 'package:fitness_app/config/network/api_result.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_exercises_by_primemuscleandlevel_usecase.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_levels_by_primemuscles_usecase.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_intent.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final GetLevelsByPrimemusclesUsecase getLevels;
  final GetExercisesByPrimaryMuscleAndLevelUseCase getExercises;

  String? _muscleId;
  String? _token;

  ExerciseCubit({
    required this.getLevels,
    required this.getExercises,
  }) : super(const ExerciseState());

  void doIntent(ExerciseIntent intent) {
    if (intent is LoadLevels) {
      _loadLevels(token: intent.token, muscleId: intent.muscleId);
    } else if (intent is SelectLevel) {
      _selectLevel(intent.index);
    }
  }

  Future<void> _loadLevels({
    required String token,
    required String muscleId,
  }) async {
    _token = token;
    _muscleId = muscleId;

    emit(state.copyWith(isLevelsLoading: true));

    final result = await getLevels(token, muscleId);

    if (result is SuccessApiResult<List<LevelModel>>) {
      final levels = result.data;
      emit(state.copyWith(isLevelsLoading: false, levels: levels));

      // Auto-load exercises for the first level
      if (levels.isNotEmpty) {
        await _loadExercises(
          muscleId: muscleId,
          levelId: levels[0].id,
          levelIndex: 0,
        );
      }
    } else if (result is ErrorApiResult<List<LevelModel>>) {
      emit(
        state.copyWith(isLevelsLoading: false, levelsError: result.error),
      );
    }
  }

  Future<void> _selectLevel(int index) async {
    if (_muscleId == null || index >= state.levels.length) return;

    emit(state.copyWith(selectedLevelIndex: index, exercises: []));

    await _loadExercises(
      muscleId: _muscleId!,
      levelId: state.levels[index].id,
      levelIndex: index,
    );
  }

  Future<void> _loadExercises({
    required String muscleId,
    required String levelId,
    required int levelIndex,
  }) async {
    emit(state.copyWith(isExercisesLoading: true));

    final result = await getExercises(muscleId, levelId);

    if (result is SuccessApiResult<List<ExerciseModel>>) {
      emit(
        state.copyWith(
          isExercisesLoading: false,
          exercises: result.data,
          selectedLevelIndex: levelIndex,
        ),
      );
    } else if (result is ErrorApiResult<List<ExerciseModel>>) {
      emit(
        state.copyWith(
          isExercisesLoading: false,
          exercisesError: result.error,
        ),
      );
    }
  }
}