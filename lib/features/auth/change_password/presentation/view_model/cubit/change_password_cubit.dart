// ignore_for_file: prefer_single_quotes

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/services/token_service.dart';
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
        emit(state.copyWith(newPasswordVisible: state.newPasswordVisible));
        break;

      case ToggleConfirmPasswordVisibility():
        emit(
          state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible),
        );
        break;
    }
  }

  Future<void> _submitChangePassword() async {
    final isValid = formKey.currentState!.validate();

    emit(state.copyWith(baseState: state.baseState.copyWith(isLoading: true)));

    final dto = ChangePasswordRequest(
      password: oldPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
    );

    final result = await _changePasswordUsecase.call(dto);
    await result.when(
      success: (data) async {
        emit(
          state.copyWith(
            baseState: state.baseState.copyWith(isLoading: false, data: data),
          ),
        );

        if (data.token != null && data.token!.isNotEmpty) {
          await _tokenService.refreshToken(data.token!);
          emit(
            state.copyWith(
              baseState: state.baseState.copyWith(isLoading: false),
            ),
          );
        }
        debugPrint('Password changed successfully: ${data.message}');
        formKey.currentState?.save();
      },

      failure: (e) async {
        emit(
          state.copyWith(
            baseState: state.baseState.copyWith(
              isLoading: false,
              errorMessage: e.message,
            ),
          ),
        );

        if (e.message.startsWith('Token expired') ||
            e.message.startsWith('Invalid token')) {
          await _tokenService.refreshToken('');
          debugPrint(
            'Token refreshed due to expiration or invalidity. Retrying change password...',
          );
          await _submitChangePassword();
        }

        debugPrint('Failed to change password: ${e.message}');
      },
      loading: () async {},
      initial: () async {},
    );
    if (!isValid) return;

    formKey.currentState?.reset();
  }

  @override
  Future<void> close() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
