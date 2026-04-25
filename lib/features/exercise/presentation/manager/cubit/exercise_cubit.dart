import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_result.dart';
import 'package:fitness_app/config/services/token_service.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_exercises_by_primemuscleandlevel_usecase.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_levels_by_primemuscles_usecase.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_intent.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_state.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseState> {
  final GetLevelsByPrimemusclesUsecase getLevels;
  final GetExercisesByPrimaryMuscleAndLevelUseCase getExercises;
  final TokenService tokenService;
  String muscleId = '';
  ExerciseCubit({
    required this.getLevels,
    required this.getExercises,
    required this.tokenService,
  }) : super(const ExerciseState());

  void doIntent(ExerciseIntent intent) {
    if (intent is LoadLevels) {
      _loadLevels(muscleId: intent.muscleId);
    } else if (intent is SelectLevel) {
      _selectLevel(intent.index);
    }
  }

  Future<void> _loadLevels({
    required String muscleId,
  }) async {
    this.muscleId = muscleId;
    emit(state.copyWith(isLevelsLoading: true));

    final tokenResponse = await tokenService.getToken();
    final String? actualToken = tokenResponse.maybeWhen(
      success: (t) => t,
      orElse: () => null,
    );

    if (actualToken == null || actualToken.isEmpty) {
      emit(state.copyWith(
        isLevelsLoading: false,
        levelsError: 'Authentication token not found',
      ));
      return;
    }

    final result = await getLevels(actualToken, muscleId);

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
    if (muscleId.isEmpty || index >= state.levels.length) return;

    emit(state.copyWith(selectedLevelIndex: index, exercises: []));

    await _loadExercises(
      muscleId: muscleId,
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