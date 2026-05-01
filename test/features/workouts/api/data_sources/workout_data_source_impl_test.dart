import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/api/data_sources/wourkout_data_source_impl.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/prime_mover_muscle_response.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/workout_response.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/wourkout_group_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late WorkoutDataSourceImpl dataSource;
  late MockWorkoutApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockWorkoutApiClient();
    dataSource = WorkoutDataSourceImpl(mockApiClient);
  });

  group('WorkoutDataSourceImpl', () {
    const tMuscleGroupId = 'test-id';

    group('getWorkouts', () {
      test(
        'should return BaseResponse.success when API call is successful',
        () async {
          // arrange
          const tResponse = WorkoutResponse();
          when(mockApiClient.getWorkouts()).thenAnswer((_) async => tResponse);

          // act
          final result = await dataSource.getWorkouts();

          // assert
          expect(result, const BaseResponse.success(tResponse));
          verify(mockApiClient.getWorkouts()).called(1);
          verifyNoMoreInteractions(mockApiClient);
        },
      );

      test(
        'should return BaseResponse.failure when API call throws exception',
        () async {
          // arrange
          when(
            mockApiClient.getWorkouts(),
          ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

          // act
          final result = await dataSource.getWorkouts();

          // assert
          expect(result, isA<BaseFailure>());
          verify(mockApiClient.getWorkouts()).called(1);
        },
      );
    });

    group('getWorkoutsByMuscleGroupId', () {
      test(
        'should return BaseResponse.success when API call is successful',
        () async {
          // arrange
          const tResponse = WourkoutGroupResponse();
          when(
            mockApiClient.getWorkoutsByMuscleGroupId(tMuscleGroupId),
          ).thenAnswer((_) async => tResponse);

          // act
          final result = await dataSource.getWorkoutsByMuscleGroupId(
            tMuscleGroupId,
          );

          // assert
          expect(result, const BaseResponse.success(tResponse));
          verify(
            mockApiClient.getWorkoutsByMuscleGroupId(tMuscleGroupId),
          ).called(1);
        },
      );
    });

    group('get20randomPrimeMoverMuscle', () {
      test(
        'should return BaseResponse.success when API call is successful',
        () async {
          // arrange
          const tResponse = PrimeMoverMuscleResponse();
          when(
            mockApiClient.get20randomPrimeMoverMuscle(),
          ).thenAnswer((_) async => tResponse);

          // act
          final result = await dataSource.get20randomPrimeMoverMuscle();

          // assert
          expect(result, const BaseResponse.success(tResponse));
          verify(mockApiClient.get20randomPrimeMoverMuscle()).called(1);
        },
      );
    });

    group('getAllPrimeMoverMusclebyMuscleGroupId', () {
      test(
        'should return BaseResponse.success when API call is successful',
        () async {
          // arrange
          const tResponse = PrimeMoverMuscleResponse();
          when(
            mockApiClient.getAllPrimeMoverMusclebyMuscleGroupId(tMuscleGroupId),
          ).thenAnswer((_) async => tResponse);

          // act
          final result = await dataSource.getAllPrimeMoverMusclebyMuscleGroupId(
            tMuscleGroupId,
          );

          // assert
          expect(result, const BaseResponse.success(tResponse));
          verify(
            mockApiClient.getAllPrimeMoverMusclebyMuscleGroupId(tMuscleGroupId),
          ).called(1);
        },
      );
    });
  });
}
