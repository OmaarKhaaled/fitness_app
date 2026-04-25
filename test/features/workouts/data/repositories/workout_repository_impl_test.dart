import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/workout_response.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/wourkout_group_response.dart';
import 'package:fitness_app/features/workouts/data/repositories/workout_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late WorkoutRepositoryImpl repository;
  late MockWorkoutDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockWorkoutDataSource();
    repository = WorkoutRepositoryImpl(mockDataSource);
  });

  group('WorkoutRepositoryImpl', () {
    const tMuscleGroupId = 'test-id';
    const tException = AppException('Test Error');

    group('getWorkouts', () {
      test(
        'should return success data when data source is successful',
        () async {
          // arrange
          const tResponse = WorkoutResponse();
          when(
            mockDataSource.getWorkouts(),
          ).thenAnswer((_) async => const BaseResponse.success(tResponse));

          // act
          final result = await repository.getWorkouts();

          // assert
          expect(result, const BaseResponse.success(tResponse));
          verify(mockDataSource.getWorkouts()).called(1);
          verifyNoMoreInteractions(mockDataSource);
        },
      );

      test('should return failure when data source fails', () async {
        // arrange
        when(
          mockDataSource.getWorkouts(),
        ).thenAnswer((_) async => const BaseResponse.failure(tException));

        // act
        final result = await repository.getWorkouts();

        // assert
        expect(result, const BaseResponse<WorkoutResponse>.failure(tException));
        verify(mockDataSource.getWorkouts()).called(1);
      });
    });

    group('getWorkoutsByMuscleGroupId', () {
      test(
        'should return success data when data source is successful',
        () async {
          // arrange
          const tResponse = WourkoutGroupResponse();
          when(
            mockDataSource.getWorkoutsByMuscleGroupId(tMuscleGroupId),
          ).thenAnswer((_) async => const BaseResponse.success(tResponse));

          // act
          final result = await repository.getWorkoutsByMuscleGroupId(
            tMuscleGroupId,
          );

          // assert
          expect(result, const BaseResponse.success(tResponse));
          verify(
            mockDataSource.getWorkoutsByMuscleGroupId(tMuscleGroupId),
          ).called(1);
        },
      );
    });

    group('get20randomPrimeMoverMuscle', () {
      test(
        'should return success data when data source is successful',
        () async {
          // arrange
          const tResponse = PrimeMoverMuscleResponse();
          when(
            mockDataSource.get20randomPrimeMoverMuscle(),
          ).thenAnswer((_) async => const BaseResponse.success(tResponse));

          // act
          final result = await repository.get20randomPrimeMoverMuscle();

          // assert
          expect(result, const BaseResponse.success(tResponse));
          verify(mockDataSource.get20randomPrimeMoverMuscle()).called(1);
        },
      );
    });

    group('getAllPrimeMoverMusclebyMuscleGroupId', () {
      test(
        'should return success data when data source is successful',
        () async {
          // arrange
          const tResponse = PrimeMoverMuscleResponse();
          when(
            mockDataSource.getAllPrimeMoverMusclebyMuscleGroupId(
              tMuscleGroupId,
            ),
          ).thenAnswer((_) async => const BaseResponse.success(tResponse));

          // act
          final result = await repository.getAllPrimeMoverMusclebyMuscleGroupId(
            tMuscleGroupId,
          );

          // assert
          expect(result, const BaseResponse.success(tResponse));
          verify(
            mockDataSource.getAllPrimeMoverMusclebyMuscleGroupId(
              tMuscleGroupId,
            ),
          ).called(1);
        },
      );
    });
  });
}
