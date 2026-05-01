import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/config/services/token_service.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_intent.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_exercises_by_primemuscleandlevel_usecase.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_levels_by_primemuscles_usecase.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercise_cubit_test.mocks.dart';

@GenerateMocks([
  GetLevelsByPrimemusclesUsecase,
  GetExercisesByPrimaryMuscleAndLevelUseCase,
  TokenService,
])
void main() {
  late MockGetLevelsByPrimemusclesUsecase getLevelsMock;
  late MockGetExercisesByPrimaryMuscleAndLevelUseCase getExercisesMock;
  late MockTokenService tokenService;

  const testExercise = ExerciseModel(id: '1', name: 'Push Up');
  const testLevels = [
    LevelModel(id: 'l1', name: 'Beginner'),
    LevelModel(id: 'l2', name: 'Advanced'),
  ];

  setUp(() {
    getLevelsMock = MockGetLevelsByPrimemusclesUsecase();
    getExercisesMock = MockGetExercisesByPrimaryMuscleAndLevelUseCase();
    tokenService = MockTokenService();

    // Mockito needs dummies for generic return types when using `any`
    provideDummy<BaseResponse<String?>>(const BaseResponse.initial());
    provideDummy<BaseResponse<List<LevelModel>>>(const BaseResponse.initial());
    provideDummy<BaseResponse<List<ExerciseModel>>>(
      const BaseResponse.initial(),
    );
  });

  ExerciseCubit buildCubit() => ExerciseCubit(
    getLevels: getLevelsMock,
    getExercises: getExercisesMock,
    tokenService: tokenService,
    exercise: testExercise,
  );

  group('doIntent', () {
    // ── LoadLevels ──

    blocTest<ExerciseCubit, ExerciseState>(
      'LoadLevels emits loading then levels on success',
      build: () {
        when(tokenService.getToken()).thenAnswer(
          (_) async => const BaseResponse.success('test_token'),
        );
        when(getLevelsMock(any, any)).thenAnswer(
          (_) async => const BaseResponse.success(testLevels),
        );
        // Auto-load exercises for first level after levels load
        when(getExercisesMock(any, any)).thenAnswer(
          (_) async => const BaseResponse.success(<ExerciseModel>[]),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doIntent(LoadLevels(testExercise)),
      expect: () => [
        // 1. Loading levels
        isA<ExerciseState>().having(
          (s) => s.isLevelsLoading,
          'isLevelsLoading',
          true,
        ),
        // 2. Levels loaded
        isA<ExerciseState>()
            .having((s) => s.isLevelsLoading, 'isLevelsLoading', false)
            .having((s) => s.levels.length, 'levels.length', 2),
        // 3. Auto-loading exercises for first level
        isA<ExerciseState>().having(
          (s) => s.isExercisesLoading,
          'isExercisesLoading',
          true,
        ),
        // 4. Exercises loaded (empty) + thumbnails filtered
        isA<ExerciseState>().having(
          (s) => s.isExercisesLoading,
          'isExercisesLoading',
          false,
        ),
      ],
      verify: (_) {
        verify(tokenService.getToken()).called(1);
        verify(getLevelsMock('test_token', '1')).called(1);
      },
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'LoadLevels emits loading then error on failure',
      build: () {
        when(tokenService.getToken()).thenAnswer(
          (_) async => const BaseResponse.success('test_token'),
        );
        when(getLevelsMock(any, any)).thenAnswer(
          (_) async => const BaseResponse.failure(
            AppException('Failed to load levels'),
          ),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doIntent(LoadLevels(testExercise)),
      expect: () => [
        // 1. Loading
        isA<ExerciseState>().having(
          (s) => s.isLevelsLoading,
          'isLevelsLoading',
          true,
        ),
        // 2. Error
        isA<ExerciseState>().having(
          (s) => s.levelsError,
          'levelsError',
          'Failed to load levels',
        ),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'LoadLevels emits error when token is null',
      build: () {
        when(tokenService.getToken()).thenAnswer(
          (_) async => const BaseResponse.success(null),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doIntent(LoadLevels(testExercise)),
      expect: () => [
        isA<ExerciseState>().having(
          (s) => s.isLevelsLoading,
          'isLevelsLoading',
          true,
        ),
        isA<ExerciseState>().having(
          (s) => s.levelsError,
          'levelsError',
          'Authentication token not found',
        ),
      ],
    );

    // ── SelectLevel ──

    blocTest<ExerciseCubit, ExerciseState>(
      'SelectLevel emits selected index and loads exercises',
      build: () {
        when(getExercisesMock(any, any)).thenAnswer(
          (_) async => const BaseResponse.success([
            ExerciseModel(id: 'e1', name: 'Bench Press'),
          ]),
        );
        return buildCubit();
      },
      // Seed with levels so _selectLevel doesn't return early
      seed: () => const ExerciseState(levels: testLevels),
      act: (cubit) => cubit.doIntent(const SelectLevel(1)),
      expect: () => [
        // 1. Selected level updated, exercises cleared
        isA<ExerciseState>().having(
          (s) => s.selectedLevelIndex,
          'selectedLevelIndex',
          1,
        ),
        // 2. Exercises loading
        isA<ExerciseState>().having(
          (s) => s.isExercisesLoading,
          'isExercisesLoading',
          true,
        ),
        // 3. Exercises loaded
        isA<ExerciseState>().having(
          (s) => s.exercises.length,
          'exercises.length',
          1,
        ),
        // 4. Thumbnails filtered (no thumbnailUrl → empty)
        isA<ExerciseState>().having(
          (s) => s.exercises.length,
          'exercises.length',
          0,
        ),
      ],
      verify: (_) {
        verify(getExercisesMock('1', 'l2')).called(1);
      },
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'SelectLevel does nothing when index is out of bounds',
      build: () => buildCubit(),
      // Empty levels list (default)
      act: (cubit) => cubit.doIntent(const SelectLevel(0)),
      expect: () => [],
      verify: (_) {
        verifyNoMoreInteractions(getLevelsMock);
        verifyNoMoreInteractions(getExercisesMock);
        verifyNoMoreInteractions(tokenService);
      },
    );
  });
}
