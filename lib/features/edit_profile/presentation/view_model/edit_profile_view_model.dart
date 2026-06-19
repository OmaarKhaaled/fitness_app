import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/upload_photo_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/get_profile_use_case.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/save_first_name_use_case.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/save_photo_use_case.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class EditProfileViewModel extends Cubit<EditProfileStates> {
  final EditProfileUseCase _editProfileUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final SaveFirstNameUseCase _saveFirstNameUseCase;
  final SavePhotoUseCase _savePhotoUseCase;
  EditProfileViewModel(
    this._editProfileUseCase,
    this._getProfileUseCase,
    this._uploadPhotoUseCase,
    this._saveFirstNameUseCase,
    this._savePhotoUseCase,
  ) : super(EditProfileStates());
  void doIntent(EditProfileEvents event) {
    switch (event) {
      case EditProfileEvent():
        _editProfile(event.requestModel);
      case GetProfileEvent():
        _getProfile();
      case ResetEditSuccessEvent():
        _resetEditSuccess();
      case UploadPhotoEvent():
        _uploadPhoto(event.photo);
      case UpdateWeightEvent():
        _updateWeight(event.weight);
      case UpdateWeightIndexEvent():
        _updateWeightIndex(event.index, event.weight);
      case UpdateGoalEvent():
        _updateGoal(event.goal);
      case SelectGoalEvent():
        _selectGoal(event.goal);
      case SelectActivityLevelEvent():
        _selectActivityLevel(event.activityLevel);
      case UpdateActivityLevelEvent():
        _updateActivityLevel(event.activityLevel);
      case SaveFirstNameEvent():
        _saveFirstName(event.key, event.value);
      case SavePhotoEvent():
        _savePhoto(event.key, event.value);
      case UpdateFirstNameEvent():
        _updateFirstName(event.firstName);
      case UpdateLastNameEvent():
        _updateLastName(event.lastName);
      case UpdateEmailEvent():
        _updateEmail(event.email);
    }
  }

  Future<void> _editProfile(EditProfileRequestModel request) async {
    emit(
      state.copyWith(
        editProfileState: const BaseState<EditProfileResponseModel>(
          isLoading: true,
        ),
        isEditSuccess: false,
      ),
    );

    final res = await _editProfileUseCase.call(request);
    res.when(
      initial: () => null,
      loading: () => null,
      success: (data) {
        emit(
          state.copyWith(
            editProfileState: BaseState<EditProfileResponseModel>(
              isLoading: false,
              data: data,
            ),
            profileState: BaseState<EditProfileResponseModel>(
              isLoading: false,
              data: data,
            ),
            isEditSuccess: true,
          ),
        );
      },
      failure: (exception) {
        emit(
          state.copyWith(
            editProfileState: BaseState<EditProfileResponseModel>(
              isLoading: false,
              errorMessage: ExceptionsHandler.handle(exception).message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _getProfile() async {
    emit(
      state.copyWith(
        profileState: const BaseState<EditProfileResponseModel>(
          isLoading: true,
        ),
      ),
    );
    final res = await _getProfileUseCase.call();
    res.when(
      initial: () => null,
      loading: () => null,
      success: (data) {
        emit(
          state.copyWith(
            profileState: BaseState<EditProfileResponseModel>(
              isLoading: false,
              data: data,
            ),
          ),
        );
      },
      failure: (exception) {
        emit(
          state.copyWith(
            profileState: BaseState<EditProfileResponseModel>(
              isLoading: false,
              errorMessage: ExceptionsHandler.handle(exception).message,
            ),
          ),
        );
      },
    );
  }

  void _resetEditSuccess() {
    emit(state.copyWith(isEditSuccess: false));
  }

  Future<void> _uploadPhoto(File photo) async {
    emit(
      state.copyWith(
        uploadState: const BaseState<UploadPhotoResponseModel>(isLoading: true),
      ),
    );

    final res = await _uploadPhotoUseCase.call(photo);

    res.when(
      initial: () => null,
      loading: () => null,
      success: (data) {
        emit(
          state.copyWith(
            uploadState: BaseState<UploadPhotoResponseModel>(
              isLoading: false,
              data: data,
            ),
          ),
        );
        _getProfile();
      },
      failure: (exception) {
        emit(
          state.copyWith(
            uploadState: BaseState<UploadPhotoResponseModel>(
              isLoading: false,
              errorMessage: ExceptionsHandler.handle(exception).message,
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateWeight(int weight) async {
    final currentState = state.profileState?.data?.userModel;
    if (currentState == null) return;
    final request = EditProfileRequestModel(
      firstName: currentState.firstName,
      lastName: currentState.lastName,
      email: currentState.email,
      weight: weight,
      goal: currentState.goal,
      activityLevel: currentState.activityLevel,
    );

    await _editProfile(request);
  }

  void _updateWeightIndex(int index, int weight) {
    emit(state.copyWith(currentWeightIndex: index, selectedWeight: weight));
  }

  void _selectGoal(String goal) {
    emit(state.copyWith(selectedGoal: goal));
  }

  Future<void> _updateGoal(String goal) async {
    final currentState = state.profileState?.data?.userModel;
    if (currentState == null) return;
    final request = EditProfileRequestModel(
      firstName: currentState.firstName,
      lastName: currentState.lastName,
      email: currentState.email,
      weight: currentState.weight,
      goal: goal,
      activityLevel: currentState.activityLevel,
    );
    await _editProfile(request);
  }

  void _selectActivityLevel(String activityLevel) {
    emit(state.copyWith(selectedActivityLevel: activityLevel));
  }

  Future<void> _updateActivityLevel(String activityLevel) async {
    final currentState = state.profileState?.data?.userModel;
    if (currentState == null) return;
    final request = EditProfileRequestModel(
      firstName: currentState.firstName,
      lastName: currentState.lastName,
      email: currentState.email,
      weight: currentState.weight,
      goal: currentState.goal,
      activityLevel: activityLevel,
    );
    await _editProfile(request);
  }

  void _saveFirstName(String key, String value) async {
    await _saveFirstNameUseCase.call(key, value);
  }

  void _savePhoto(String key, String value) async {
    await _savePhotoUseCase.call(key, value);
  }

  Future<void> _updateFirstName(String firstName) async {
    final currentState = state.profileState?.data?.userModel;
    if (currentState == null) return;

    final request = EditProfileRequestModel(
      firstName: firstName,
      lastName: currentState.lastName,
      email: currentState.email,
      weight: currentState.weight,
      goal: currentState.goal,
      activityLevel: currentState.activityLevel,
    );
    await _editProfile(request);
    _saveFirstName(CacheConstants.firstName, firstName);
  }

  Future<void> _updateLastName(String lastName) async {
    final currentState = state.profileState?.data?.userModel;
    if (currentState == null) return;

    final request = EditProfileRequestModel(
      firstName: currentState.firstName,
      lastName: lastName,
      email: currentState.email,
      weight: currentState.weight,
      goal: currentState.goal,
      activityLevel: currentState.activityLevel,
    );

    await _editProfile(request);
  }

  Future<void> _updateEmail(String email) async {
    final currentState = state.profileState?.data?.userModel;
    if (currentState == null) return;

    final request = EditProfileRequestModel(
      firstName: currentState.firstName,
      lastName: currentState.lastName,
      email: email,
      weight: currentState.weight,
      goal: currentState.goal,
      activityLevel: currentState.activityLevel,
    );

    await _editProfile(request);
  }
}
