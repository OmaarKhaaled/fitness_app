import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
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

  ChangePasswordCubit(this._changePasswordUsecase)
    : super(ChangePasswordState.initial()) {
    currentPasswordController.addListener(_onTextChanged);
    newPasswordController.addListener(_onTextChanged);
    confirmPasswordController.addListener(_onTextChanged);
  }

  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _onTextChanged() {
    _validateForm(ChangePasswordRequest());
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  void doIntent(ChangePaaswordIntent intent) {
    switch (intent) {
      case FormChangedIntent():
        _validateForm(ChangePasswordRequest());
      case ToggleCurrentPasswordVisibility():
        _toggleCurrentPasswordVisibility();
      case ToggleNewPasswordVisibility():
        _toggleNewPasswordVisibility();
      case ToggleConfirmPasswordVisibility():
        _toggleConfirmPasswordVisibility();
      case SubmitChangePasswordIntent():
        _submitChangePassword();
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
    // Removed redundant isLoading: true emit
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

    final result = await _changePasswordUsecase(
      ChangePasswordRequest(
        newPassword: newPasswordController.text,
        password: currentPasswordController.text,
      ),
    );
    if (isClosed) return;

    result.when(
      initial: () => emit(
        state.copyWith(baseState: state.baseState.copyWith(isLoading: false)),
      ),
      loading: () => emit(
        state.copyWith(baseState: state.baseState.copyWith(isLoading: true)),
      ),
      success: (data) {
        emit(
          state.copyWith(
            baseState: state.baseState.copyWith(isLoading: false, data: data),
          ),
        );
      },
      failure: (exception) {
        emit(
          state.copyWith(
            baseState: state.baseState.copyWith(
              isLoading: false,
              errorMessage: exception.message,
            ),
          ),
        );
      },
    );

  }
}
