import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/change_password/domain/usecases/change_password_usecase.dart';
import 'package:fitness_app/features/change_password/presentation/view_model/cubit/change_paasword_intent.dart';
import 'package:injectable/injectable.dart';

import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/change_password/domain/models/change_password_model.dart';

part 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUsecase _changePasswordUsecase;

  ChangePasswordCubit(this._changePasswordUsecase)
    : super(ChangePasswordState.initial());

  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void doIntent(ChangePaaswordIntent intent) {
    switch (intent.runtimeType) {
      case FormChangedIntent:
        _validateForm(ChangePasswordRequest());
        break;
      case ToggleCurrentPasswordVisibility():
        _toggleCurrentPasswordVisibility;
        break;
      case ToggleNewPasswordVisibility():
        _toggleNewPasswordVisibility;
        break;

      case ToggleConfirmPasswordVisibility():
        _toggleConfirmPasswordVisibility;
        break;
      case SubmitChangePasswordIntent:
        _submitChangePassword();
        break;
    }
  }

  Future<void> _validateForm(ChangePasswordRequest request) async {
    final current = currentPasswordController;
    final newPass = newPasswordController;
    final confirm = confirmPasswordController;

    final isValid =
        current.text.isNotEmpty &&
        newPass.text.isNotEmpty &&
        confirm.text.isNotEmpty &&
        AppValidators.validatePassword(newPass.text) == null &&
        newPass.text == confirm.text;

    emit(state.copyWith(isFormValid: isValid));
    emit(state.copyWith(baseState: state.baseState.copyWith(isLoading: true)));
    // final result = await _changePasswordUsecase.call(request);
  }

  _toggleNewPasswordVisibility() {
    emit(state.copyWith(newPasswordVisible: !state.newPasswordVisible));
  }

  _toggleCurrentPasswordVisibility() {
    emit(state.copyWith(currentPasswordVisible: !state.currentPasswordVisible));
  }

  _toggleConfirmPasswordVisibility() {
    emit(state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible));
  }

  _submitChangePassword() async {
    if (!state.isFormValid) return;
    emit(state.copyWith(baseState: state.baseState.copyWith(isLoading: true)));
  }
}
