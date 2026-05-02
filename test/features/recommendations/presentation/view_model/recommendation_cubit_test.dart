import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/muscle.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/recommendations/presentation/view_model/recommendation_cubit.dart';
import 'package:fitness_app/features/recommendations/presentation/view_model/recommendation_intents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../workouts/helpers/test_helper.mocks.dart';

void main() {
  late RecommendationCubit cubit;
  late MockGetRandom20PrimeMoverMuscleUseCase
  mockGetRandom20PrimeMoverMuscleUseCase;

  setUp(() {
    mockGetRandom20PrimeMoverMuscleUseCase =
        MockGetRandom20PrimeMoverMuscleUseCase();
    cubit = RecommendationCubit(
      getRecommendationsUseCase: mockGetRandom20PrimeMoverMuscleUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('RecommendationCubit', () {
    const tMuscle = Muscle(id: '1', name: 'Chest');
    const tException = AppException('Error');

    test('initial state should be empty', () {
      expect(cubit.state.isLoading, false);
      expect(cubit.state.data, isNull);
    });

    group('LoadRecommendationsIntent', () {
      test('should load recommendations successfully', () async {
        // arrange
        const tResponse = PrimeMoverMuscleResponse(muscles: [tMuscle]);

        when(
          mockGetRandom20PrimeMoverMuscleUseCase(),
        ).thenAnswer((_) async => const BaseResponse.success(tResponse));

        // act
        cubit.doIntent(const LoadRecommendationsIntent());

        // assert
        await Future.delayed(Duration.zero);
        expect(cubit.state.isLoading, false);
        expect(cubit.state.data, [tMuscle]);

        verify(mockGetRandom20PrimeMoverMuscleUseCase()).called(1);
      });

      test('should handle error when load fails', () async {
        // arrange
        when(
          mockGetRandom20PrimeMoverMuscleUseCase(),
        ).thenAnswer((_) async => const BaseResponse.failure(tException));

        // act
        cubit.doIntent(const LoadRecommendationsIntent());

        // assert
        await Future.delayed(Duration.zero);
        expect(cubit.state.isLoading, false);
        expect(cubit.state.data, isNull);
        expect(cubit.state.errorMessage, 'Error');

        verify(mockGetRandom20PrimeMoverMuscleUseCase()).called(1);
      });
    });
  });
}
