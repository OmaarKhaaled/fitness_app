import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/services/token_service.dart';
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
  final TokenService _tokenService;

  ChangePasswordCubit(this._changePasswordUsecase, this._tokenService)
    : super(ChangePasswordState.initial()) {
    oldPasswordController.addListener(_onTextChanged);
    newPasswordController.addListener(_onTextChanged);
    confirmPasswordController.addListener(_onTextChanged);
  }

  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _onTextChanged() {
    _validateForm();
  }

  @override
  Future<void> close() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  void doIntent(ChangePaaswordIntent intent) {
    switch (intent) {
      case FormChangedIntent():
        _validateForm();
      case ToggleOldPasswordVisibility():
        _toggleOldPasswordVisibility();
      case ToggleNewPasswordVisibility():
        _toggleNewPasswordVisibility();
      case ToggleConfirmPasswordVisibility():
        _toggleConfirmPasswordVisibility();
      case SubmitChangePasswordIntent():
        _submitChangePassword();
      case ErrorMessageIntent():
        _validateForm();
    }
  }

  void _validateForm() {
    final oldPass = oldPasswordController.text;
    final newPass = newPasswordController.text;
    final confirm = confirmPasswordController.text;

    final isValid =
        oldPass.isNotEmpty &&
        newPass.isNotEmpty &&
        confirm.isNotEmpty &&
        AppValidators.validatePassword(newPass) == null &&
        newPass == confirm;

    if (state.isFormValid != isValid || state.baseState.errorMessage != null) {
      emit(
        state.copyWith(
          isFormValid: isValid,
          baseState: state.baseState.copyWith(errorMessage: null),
        ),
      );
    }
  }

  _toggleNewPasswordVisibility() {
    emit(state.copyWith(newPasswordVisible: !state.newPasswordVisible));
  }

  _toggleOldPasswordVisibility() {
    emit(state.copyWith(oldPasswordVisible: !state.oldPasswordVisible));
  }

  _toggleConfirmPasswordVisibility() {
    emit(state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible));
  }

  Future<void> _submitChangePassword() async {
    if (!state.isFormValid || state.baseState.isLoading) return;
    emit(state.copyWith(baseState: state.baseState.copyWith(isLoading: true)));

    final result = await _changePasswordUsecase(
      ChangePasswordRequest(
        newPassword: newPasswordController.text,
        password: oldPasswordController.text,
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
        if ((data.token?.isNotEmpty ?? false)) {
          _tokenService.saveToken(data.token!);
        }
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
