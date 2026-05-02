import 'dart:async';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_workouts_use_case.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_workouts_by_muscle_group_id_use_case.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/workout_states.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/wourkout_intents.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/wourkout_ui_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkoutCubit extends Cubit<WorkoutStates> {
  final GetWorkoutsUseCase _getWorkoutsUseCase;
  final GetWorkoutsByMuscleGroupIdUseCase _getWorkoutsByMuscleGroupIdUseCase;
  final StreamController<WorkoutUiIntents> _streamController =
      StreamController<WorkoutUiIntents>.broadcast();

  Stream<WorkoutUiIntents> get uiIntents => _streamController.stream;

  WorkoutCubit({
    required GetWorkoutsUseCase getWorkoutsUseCase,
    required GetWorkoutsByMuscleGroupIdUseCase
    getWorkoutsByMuscleGroupIdUseCase,
  }) : _getWorkoutsUseCase = getWorkoutsUseCase,
       _getWorkoutsByMuscleGroupIdUseCase = getWorkoutsByMuscleGroupIdUseCase,
       super(WorkoutStates());

  void doIntent(WorkoutIntents intent) {
    switch (intent) {
      case LoadInitialDataIntent():
        _loadInitialData();
        break;
      case SelectMuscleGroupIntent(
        muscleGroupId: final id,
        muscleGroupName: final name,
      ):
        _selectMuscleGroup(id, name);
        break;
      case RefreshWorkoutsIntent():
        _loadInitialData();
        break;
    }
  }

  Future<void> _loadInitialData() async {
    emit(state.copyWith(isMuscleGroupsLoading: true, isMusclesLoading: true));

    final response = await _getWorkoutsUseCase();
    if (isClosed) return;

    response.when(
      initial: () => null,
      loading: () => null,
      success: (data) {
        final groups = data.musclesGroup ?? [];
        emit(
          state.copyWith(isMuscleGroupsLoading: false, muscleGroups: groups),
        );

        if (groups.isNotEmpty && state.selectedMuscleGroupId == null) {
          _loadMusclesByGroupId(groups.first.id!, groups.first.name!);
        } else if (state.selectedMuscleGroupId != null) {
          _loadMusclesByGroupId(
            state.selectedMuscleGroupId!,
            state.selectedMuscleGroupName,
          );
        } else {
          emit(state.copyWith(isMusclesLoading: false));
        }
      },
      failure: (error) {
        emit(
          state.copyWith(isMuscleGroupsLoading: false, isMusclesLoading: false),
        );
        _streamController.add(ShowErrorWorkoutIntent(error: error.message));
      },
    );
  }

  Future<void> _selectMuscleGroup(String? muscleGroupId, String name) async {
    if (muscleGroupId == state.selectedMuscleGroupId) return;

    emit(
      state.copyWith(
        selectedMuscleGroupId: muscleGroupId,
        selectedMuscleGroupName: name,
        isMusclesLoading: true,
      ),
    );

    if (muscleGroupId != null) {
      _loadMusclesByGroupId(muscleGroupId, name);
    }
  }

  Future<void> _loadMusclesByGroupId(String muscleGroupId, String name) async {
    emit(
      state.copyWith(
        isMusclesLoading: true,
        selectedMuscleGroupId: muscleGroupId,
        selectedMuscleGroupName: name,
      ),
    );

    final response = await _getWorkoutsByMuscleGroupIdUseCase(muscleGroupId);
    if (isClosed) return;

    response.when(
      initial: () => null,
      loading: () => null,
      success: (data) {
        emit(
          state.copyWith(isMusclesLoading: false, muscles: data.muscles ?? []),
        );
      },
      failure: (error) {
        emit(state.copyWith(isMusclesLoading: false));
        _streamController.add(ShowErrorWorkoutIntent(error: error.message));
      },
    );
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }
}
