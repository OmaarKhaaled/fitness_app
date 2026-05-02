import 'dart:math';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/services/token_service.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_exercises_by_primemuscleandlevel_usecase.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_levels_by_primemuscles_usecase.dart';
import 'package:fitness_app/features/popular_tarining/domain/models/popular_training_item.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view_model/popular_training_intents.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view_model/popular_training_states.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/muscle.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_random_prime_mover_muscle_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PopularTrainingCubit extends Cubit<PopularTrainingStates> {
  final GetRandom20PrimeMoverMuscleUseCase _getRandomMusclesUseCase;
  final GetLevelsByPrimemusclesUsecase _getLevelsUseCase;
  final GetExercisesByPrimaryMuscleAndLevelUseCase _getExercisesUseCase;
  final TokenService _tokenService;

  PopularTrainingCubit({
    required GetRandom20PrimeMoverMuscleUseCase getRandomMusclesUseCase,
    required GetLevelsByPrimemusclesUsecase getLevelsUseCase,
    required GetExercisesByPrimaryMuscleAndLevelUseCase getExercisesUseCase,
    required TokenService tokenService,
  }) : _getRandomMusclesUseCase = getRandomMusclesUseCase,
       _getLevelsUseCase = getLevelsUseCase,
       _getExercisesUseCase = getExercisesUseCase,
       _tokenService = tokenService,
       super(const PopularTrainingStates());

  void doIntent(PopularTrainingIntents intent) {
    switch (intent) {
      case LoadPopularTrainingIntent():
        _loadPopularTraining();
        break;
    }
  }

  Future<void> _loadPopularTraining() async {
    emit(state.copyWith(isLoading: true));

    final musclesResponse = await _getRandomMusclesUseCase();

    final muscles = musclesResponse.whenOrNull(success: (data) => data.muscles);

    if (muscles == null || muscles.isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: musclesResponse.whenOrNull(
            failure: (error) => error.message,
          ),
        ),
      );
      return;
    }

    final tokenResponse = await _tokenService.getToken();
    final String? token = tokenResponse.maybeWhen(
      success: (t) => t,
      orElse: () => null,
    );

    if (token == null || token.isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Authentication token not found',
        ),
      );
      return;
    }

    final random = Random();
    final shuffledMuscles = List<Muscle>.from(muscles)..shuffle(random);

    final selectedMuscles = shuffledMuscles.take(6).toList();
    final List<PopularTrainingItem> trainingItems = [];

    for (final muscle in selectedMuscles) {
      if (isClosed) return;
      if (muscle.id == null) continue;

      try {
        final levelsResult = await _getLevelsUseCase(token, muscle.id!);

        List<LevelModel> levels = [];
        if (levelsResult is BaseSuccess<List<LevelModel>>) {
          levels = levelsResult.data;
        }

        int exerciseCount = 0;
        final String displayLevel = levels.isNotEmpty
            ? levels[random.nextInt(levels.length)].name
            : 'All Levels';
        if (levels.isNotEmpty) {
          final exerciseResult = await _getExercisesUseCase(
            muscle.id!,
            levels.first.id,
          );

          if (exerciseResult is BaseSuccess<List<ExerciseModel>>) {
            exerciseCount = exerciseResult.data.length;
          }
        }

        trainingItems.add(
          PopularTrainingItem(
            muscle: muscle,
            levels: levels,
            exerciseCount: exerciseCount,
            displayLevel: displayLevel,
          ),
        );
      } catch (_) {
        continue;
      }
    }

    if (isClosed) return;
    emit(state.copyWith(isLoading: false, data: trainingItems));
  }
}
