import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/config/services/token_service.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_exercises_by_primemuscleandlevel_usecase.dart';
import 'package:fitness_app/features/exercise/domain/usecases/get_levels_by_primemuscles_usecase.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view_model/popular_training_cubit.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view_model/popular_training_intents.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view_model/popular_training_states.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/muscle.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_random_prime_mover_muscle_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_training_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetRandom20PrimeMoverMuscleUseCase>(),
  MockSpec<GetLevelsByPrimemusclesUsecase>(),
  MockSpec<GetExercisesByPrimaryMuscleAndLevelUseCase>(),
  MockSpec<TokenService>(),
])
void main() {
  late MockGetRandom20PrimeMoverMuscleUseCase mockGetRandomMusclesUseCase;
  late MockGetLevelsByPrimemusclesUsecase mockGetLevelsUseCase;
  late MockGetExercisesByPrimaryMuscleAndLevelUseCase mockGetExercisesUseCase;
  late MockTokenService mockTokenService;
  late PopularTrainingCubit cubit;

  setUp(() {
    mockGetRandomMusclesUseCase = MockGetRandom20PrimeMoverMuscleUseCase();
    mockGetLevelsUseCase = MockGetLevelsByPrimemusclesUsecase();
    mockGetExercisesUseCase = MockGetExercisesByPrimaryMuscleAndLevelUseCase();
    mockTokenService = MockTokenService();

    cubit = PopularTrainingCubit(
      getRandomMusclesUseCase: mockGetRandomMusclesUseCase,
      getLevelsUseCase: mockGetLevelsUseCase,
      getExercisesUseCase: mockGetExercisesUseCase,
      tokenService: mockTokenService,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('PopularTrainingCubit', () {
    const tMuscles = [
      const Muscle(id: '1', name: 'Chest', image: 'image1.jpg'),
      const Muscle(id: '2', name: 'Back', image: 'image2.jpg'),
    ];
    const tPrimeMoverMuscleResponse = PrimeMoverMuscleResponse(
      message: 'Success',
      totalMuscles: 2,
      muscles: tMuscles,
    );

    const tLevels = [
      LevelModel(id: 'l1', name: 'Beginner'),
      LevelModel(id: 'l2', name: 'Intermediate'),
    ];

    const tExercises = [
      ExerciseModel(id: 'e1', name: 'Push Up'),
      ExerciseModel(id: 'e2', name: 'Bench Press'),
    ];

    test('initial state should be PopularTrainingStates()', () {
      expect(cubit.state, const PopularTrainingStates());
    });

    blocTest<PopularTrainingCubit, PopularTrainingStates>(
      'emits [isLoading: true, data: List<PopularTrainingItem>] when LoadPopularTrainingIntent is added and data is fetched successfully',
      build: () {
        when(mockGetRandomMusclesUseCase.call()).thenAnswer(
          (_) async => const BaseResponse.success(tPrimeMoverMuscleResponse),
        );
        when(
          mockTokenService.getToken(),
        ).thenAnswer((_) async => const BaseResponse.success('fake_token'));
        when(
          mockGetLevelsUseCase.call(any, any),
        ).thenAnswer((_) async => const BaseResponse.success(tLevels));
        when(
          mockGetExercisesUseCase.call(any, any),
        ).thenAnswer((_) async => const BaseResponse.success(tExercises));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const LoadPopularTrainingIntent()),
      expect: () => [
        const PopularTrainingStates(isLoading: true),
        isA<PopularTrainingStates>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.data!.length, 'data length', 2)
            .having((s) => s.data!.first.exerciseCount, 'exercise count', 2)
            .having((s) => s.data!.first.muscle.name, 'muscle name', isNotNull),
      ],
    );

    blocTest<PopularTrainingCubit, PopularTrainingStates>(
      'emits [isLoading: true, errorMessage] when fetching muscles fails',
      build: () {
        when(mockGetRandomMusclesUseCase.call()).thenAnswer(
          (_) async => const BaseResponse.failure(
            AppException('Error fetching muscles'),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const LoadPopularTrainingIntent()),
      expect: () => [
        const PopularTrainingStates(isLoading: true),
        const PopularTrainingStates(
          isLoading: false,
          errorMessage: 'Error fetching muscles',
        ),
      ],
    );

    blocTest<PopularTrainingCubit, PopularTrainingStates>(
      'emits [isLoading: true, errorMessage] when token is not found',
      build: () {
        when(mockGetRandomMusclesUseCase.call()).thenAnswer(
          (_) async => const BaseResponse.success(tPrimeMoverMuscleResponse),
        );
        when(
          mockTokenService.getToken(),
        ).thenAnswer((_) async => const BaseResponse.success(''));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const LoadPopularTrainingIntent()),
      expect: () => [
        const PopularTrainingStates(isLoading: true),
        const PopularTrainingStates(
          isLoading: false,
          errorMessage: 'Authentication token not found',
        ),
      ],
    );
  });
}
