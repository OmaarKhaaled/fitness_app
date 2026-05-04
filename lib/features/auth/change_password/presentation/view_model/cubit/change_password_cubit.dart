// ignore_for_file: prefer_single_quotes

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/services/token_service.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/auth/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/auth/change_password/domain/usecases/change_password_usecase.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_paasword_intent.dart';
import 'package:injectable/injectable.dart';

import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/auth/change_password/domain/models/change_password_model.dart';

part 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUsecase _changePasswordUsecase;
  final TokenService _tokenService;

  ChangePasswordCubit(this._changePasswordUsecase, this._tokenService)
    : super(ChangePasswordState.initial());

  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void doIntent(ChangePasswordIntent intent) {
    switch (intent) {
      case SubmitChangePasswordIntent():
        _submitChangePassword();
        break;

      case ToggleOldPasswordVisibility():
        emit(state.copyWith(oldPasswordVisible: !state.oldPasswordVisible));
        break;

      case ToggleNewPasswordVisibility():
        emit(state.copyWith(newPasswordVisible: !state.newPasswordVisible));
        break;

      case ToggleConfirmPasswordVisibility():
        emit(
          state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible),
        );
        break;
    }
  }

  Future<void> _submitChangePassword() async {
    emit(state.copyWith(baseState: state.baseState.copyWith(isLoading: true)));

    final dto = ChangePasswordRequest(
      password: oldPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
    );

    final result = await _changePasswordUsecase.call(dto);
    final accessToken = await _tokenService.getToken();
    if (kDebugMode) {
      print("accessToken: $accessToken");
    }
    result.when(
      success: (data) => emit(
        state.copyWith(
          baseState: state.baseState.copyWith(isLoading: false, data: data),
        ),
      ),
      failure: (e) => emit(
        state.copyWith(
          baseState: state.baseState.copyWith(
            isLoading: false,
            errorMessage: e.message,
          ),
        ),
      ),
      loading: () {},
      initial: () {},
    );
  }

  @override
  Future<void> close() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
