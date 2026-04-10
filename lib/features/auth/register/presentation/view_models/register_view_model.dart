import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_response_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/domain/use_cases/register_use_case.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class RegisterViewModel extends Cubit<RegisterStates> {
  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase)
    : super(
        RegisterStates(
          registerationData: RegisterationDataModel(
            firstName: '',
            lastName: '',
            email: '',
            password: '',
            rePassword: '',
          ),
          selectedAge: 25,
        ),
      );
  void doIntent(RegisterEvents event) {
    switch (event) {
      case RegisterEvent():
        _register(event.request);
      case TogglePasswordHiddenEvent():
        _togglePasswordHidden();
      case ToggleRePasswordHiddenEvent():
        _toggleRePasswordHidden();
      case UpdateRegistrationDataEvent():
        _updateRegistrationData(event.updatedData);
      case NextPageEvent():
        _nextPage();
      case PreviousPageEvent():
        _previousPage();
      case SubmitRegistrationEvent():
        _submitRegistration();
      case SelectGenderEvent():
        _selectGender(event.gender);
      case CacheRegistrationDataEvent():
        _cacheRegistrationData(event.data);
      case SelectAgeEvent():
        _selectAge(event.age);
      case SelectWeightEvent():
        _selectWeight(event.weight);
      case SelectHeightEvent():
        _selectHeight(event.height);
      case SelectGoalEvent():
        _selectGoal(event.goal);
      case SelectActivityLevelEvent():
        _selectActivityLevel(event.activityLevel);
    }
  }

  Future<void> _register(RegisterRequestModel request) async {
    emit(state.copyWith(registerState: const BaseState(isLoading: true)));
    final res = await _registerUseCase.call(request);
    res.when(
      success: (data) {
        emit(
          state.copyWith(
            registerState: BaseState<RegisterResponseModel>(
              isLoading: false,
              data: data,
            ),
          ),
        );
      },
      failure: (exception) {
        emit(
          state.copyWith(
            registerState: const BaseState<RegisterResponseModel>(
              isLoading: false,
              isError: true,
            ),
          ),
        );
      },
    );
  }

  void _togglePasswordHidden() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  void _toggleRePasswordHidden() {
    emit(state.copyWith(isRePasswordHidden: !state.isRePasswordHidden));
  }

  void _updateRegistrationData(RegisterationDataModel updatedData) {
    emit(state.copyWith(registerationData: updatedData));
  }

  void _nextPage() {
    if (state.currentPageIndex < 5) {
      emit(state.copyWith(currentPageIndex: state.currentPageIndex + 1));
    }
  }

  void _previousPage() {
    if (state.currentPageIndex > 0) {
      emit(state.copyWith(currentPageIndex: state.currentPageIndex - 1));
    }
  }

  void _submitRegistration() {
    final request = state.registerationData.toRegisterRequest();
    _register(request);
  }

  void _selectGender(String gender) {
    emit(state.copyWith(selectedGender: gender));
    final updatedData = state.registerationData.copyWith(gender: gender);
    emit(state.copyWith(registerationData: updatedData));
  }

  void _cacheRegistrationData(RegisterationDataModel data) {
    emit(state.copyWith(cachedRegistrationData: data, registerationData: data));
  }

  void _selectAge(int age) {
    emit(state.copyWith(selectedAge: age));
    final updatedData = state.registerationData.copyWith(age: age);
    emit(state.copyWith(registerationData: updatedData));
  }

  void _selectWeight(int weight) {
    emit(state.copyWith(selectedWeight: weight));
    final updatedData = state.registerationData.copyWith(weight: weight);
    emit(state.copyWith(registerationData: updatedData));
  }

  void _selectHeight(int height) {
    emit(state.copyWith(selectedHeight: height));
    final updatedData = state.registerationData.copyWith(height: height);
    emit(state.copyWith(registerationData: updatedData));
  }

  void _selectGoal(String goal) {
    emit(state.copyWith(selectedGoal: goal));
    final updatedData = state.registerationData.copyWith(goal: goal);
    emit(state.copyWith(registerationData: updatedData));
  }

  void _selectActivityLevel(String activityLevel) {
    emit(state.copyWith(selectedActivityLevel: activityLevel));
    final updatedData = state.registerationData.copyWith(
      activityLevel: activityLevel,
    );
    emit(state.copyWith(registerationData: updatedData));
  }
}
