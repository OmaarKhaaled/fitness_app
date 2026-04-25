import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/workout_response.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/muscle.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/muscles_group.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/wourkout_group_response.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/workout_states.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/wourkout_cubit.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/wourkout_intents.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/wourkout_ui_intents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late WorkoutCubit cubit;
  late MockGetWorkoutsUseCase mockGetWorkoutsUseCase;
  late MockGetWorkoutsByMuscleGroupIdUseCase
  mockGetWorkoutsByMuscleGroupIdUseCase;

  setUp(() {
    mockGetWorkoutsUseCase = MockGetWorkoutsUseCase();
    mockGetWorkoutsByMuscleGroupIdUseCase =
        MockGetWorkoutsByMuscleGroupIdUseCase();
    cubit = WorkoutCubit(
      getWorkoutsUseCase: mockGetWorkoutsUseCase,
      getWorkoutsByMuscleGroupIdUseCase: mockGetWorkoutsByMuscleGroupIdUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('WorkoutCubit', () {
    const tMuscleGroup = MusclesGroup(id: '1', name: 'Chest');
    const tMuscle = Muscle(id: '1', name: 'Pectoralis');
    const tException = AppException('Error');

    test('initial state should be empty', () {
      expect(cubit.state, const WorkoutStates());
    });

    group('LoadInitialDataIntent', () {
      test(
        'should load muscle groups and then load muscles for the first group',
        () async {
          // arrange
          const tWorkoutResponse = WorkoutResponse(
            musclesGroup: [tMuscleGroup],
          );
          const tGroupResponse = WourkoutGroupResponse(muscles: [tMuscle]);

          when(mockGetWorkoutsUseCase()).thenAnswer(
            (_) async => const BaseResponse.success(tWorkoutResponse),
          );
          when(
            mockGetWorkoutsByMuscleGroupIdUseCase(tMuscleGroup.id),
          ).thenAnswer((_) async => const BaseResponse.success(tGroupResponse));

          // act
          cubit.doIntent(const LoadInitialDataIntent());

          // assert (since we are doing manual stream checking, we wait for the event loop)
          await Future.delayed(Duration.zero);

          expect(cubit.state.isMuscleGroupsLoading, false);
          expect(cubit.state.muscleGroups, [tMuscleGroup]);
          expect(cubit.state.selectedMuscleGroupId, tMuscleGroup.id);

          await Future.delayed(Duration.zero);
          expect(cubit.state.isMusclesLoading, false);
          expect(cubit.state.muscles, [tMuscle]);

          verify(mockGetWorkoutsUseCase()).called(1);
          verify(
            mockGetWorkoutsByMuscleGroupIdUseCase(tMuscleGroup.id),
          ).called(1);
        },
      );

      test('should emit error UI intent when getWorkouts fails', () async {
        // arrange
        when(
          mockGetWorkoutsUseCase(),
        ).thenAnswer((_) async => const BaseResponse.failure(tException));

        cubit.uiIntents.listen(
          expectAsync1((intent) {
            expect(intent, isA<ShowErrorWorkoutIntent>());
            expect((intent as ShowErrorWorkoutIntent).error, 'Error');
          }),
        );

        // act
        cubit.doIntent(const LoadInitialDataIntent());

        // assert
        await Future.delayed(Duration.zero);
        expect(cubit.state.isMuscleGroupsLoading, false);
      });
    });

    group('SelectMuscleGroupIntent', () {
      test('should load muscles for the selected group', () async {
        // arrange
        const tGroupResponse = WourkoutGroupResponse(muscles: [tMuscle]);
        when(
          mockGetWorkoutsByMuscleGroupIdUseCase('2'),
        ).thenAnswer((_) async => const BaseResponse.success(tGroupResponse));

        // act
        cubit.doIntent(
          const SelectMuscleGroupIntent(
            muscleGroupId: '2',
            muscleGroupName: 'Back',
          ),
        );

        // assert
        await Future.delayed(Duration.zero);

        expect(cubit.state.selectedMuscleGroupId, '2');
        expect(cubit.state.selectedMuscleGroupName, 'Back');
        expect(cubit.state.isMusclesLoading, false);
        expect(cubit.state.muscles, [tMuscle]);

        verify(mockGetWorkoutsByMuscleGroupIdUseCase('2')).called(1);
      });
    });
  });
}
