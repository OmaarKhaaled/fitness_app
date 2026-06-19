import 'dart:async';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_ui_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/auth/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:fitness_app/features/auth/profile/domain/usecases/logout_usecase.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_intents.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.getUserProfileUseCase, this.logoutUseCase)
    : super(ProfileStates());

  final StreamController<ProfileUiIntents> _uiController =
      StreamController<ProfileUiIntents>.broadcast();

  Stream<ProfileUiIntents> get uiIntents => _uiController.stream;

  final GetUserProfileUseCase getUserProfileUseCase;
  final LogoutUseCase logoutUseCase;

  void doIntent(ProfileIntents intent) async {
    switch (intent) {
      case GetUserProfileIntent():
        await _getUserProfile();
        break;
      case LogoutIntent():
        await _logout();
        break;
    }
  }

  Future<void> _getUserProfile() async {
    emit(state.copyWith(isLoading: true));
    final result = await getUserProfileUseCase();
    if (isClosed) return;
    result.when(
      initial: () {},
      loading: () {},
      success: (data) {
        emit(state.copyWith(data: data, isLoading: false));
      },
      failure: (failure) {
        emit(state.copyWith(errorMessage: failure.message, isLoading: false));
        _uiController.add(ShowErrorIntent(failure.message));
      },
    );
  }

  Future<void> _logout() async {
    emit(state.copyWith(isLoading: true));
    final result = await logoutUseCase();
    if (isClosed) return;
    result.when(
      initial: () {},
      loading: () {},
      success: (data) {
        emit(state.copyWith(isLoading: false));
      },
      failure: (failure) {
        emit(state.copyWith(errorMessage: failure.message, isLoading: false));
        _uiController.add(ShowErrorIntent(failure.message));
      },
    );
  }

  @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}
