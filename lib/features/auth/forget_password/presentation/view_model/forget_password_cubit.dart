import 'dart:async';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/validators/app_regex.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/domain/use_cases/verify_code_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_intents.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_states.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_ui_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final StreamController<ForgetPasswordUiIntents> _streamController =
      StreamController<ForgetPasswordUiIntents>.broadcast();

  Stream<ForgetPasswordUiIntents> get uiIntents => _streamController.stream;

  ForgetPasswordCubit({
    required this.forgetPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.verifyCodeUseCase,
  }) : super(const ForgetPasswordStates());

  void doIntent(ForgetPasswordIntents intent) {
    switch (intent) {
      case EmailChangedIntent(email: final email):
        _handleEmailChanged(email);
        break;
      case SendOtpIntent():
        _handleSendOtp();
        break;
      case OtpCodeChangedIntent(otpCode: final otpCode):
        _handleOtpCodeChanged(otpCode);
        break;
      case ConfirmOtpCodeIntent():
        _handleConfirmOtpCode();
        break;
      case ResendOtpCodeIntent(email: final email):
        _handleResendOtpCode(email);
        break;
      case NewPasswordChangedIntent(newPassword: final newPassword):
        _handleNewPasswordChanged(newPassword);
        break;
      case ConfirmNewPasswordChangedIntent(
        confirmNewPassword: final confirmNewPassword,
      ):
        _handleConfirmNewPasswordChanged(confirmNewPassword);
        break;
      case ResetPasswordIntent():
        _handleResetPassword();
        break;
    }
  }

  void _handleEmailChanged(String email) {
    emit(
      state.copyWith(email: email, isEmailValid: AppRegex.isEmailValid(email)),
    );
  }

  Future<void> _handleSendOtp() async {
    if (!state.isEmailValid) {
      _streamController.add(
        ShowErrorProvideEmailIntent(
          error: AppTextConstants.pleaseEnterValidEmail,
        ),
      );
      return;
    }
    emit(state.copyWith(isSendOtpLoading: true));
    final request = ForgetPasswordRequestModel(email: state.email);
    final response = await forgetPasswordUseCase(request);
    response.when(
      initial: () => null,
      loading: () => null,
      success: (_) {
        emit(state.copyWith(isSendOtpLoading: false));
        _streamController.add(NavigateToVerifyCodeIntent());
      },
      failure: (error) {
        emit(state.copyWith(isSendOtpLoading: false));
        _streamController.add(
          ShowErrorProvideEmailIntent(error: error.message),
        );
      },
    );
  }

  void _handleOtpCodeChanged(String otpCode) {
    emit(state.copyWith(otp: otpCode, isOtpValid: _validateOtp(otpCode)));
  }

  bool? _validateOtp(String otpCode) {
    if (otpCode.isEmpty) {
      return null;
    }
    return otpCode.length == 6 && int.tryParse(otpCode) != null;
  }

  Future<void> _handleConfirmOtpCode() async {
    if (!state.isOtpCodeValid) {
      _streamController.add(
        ShowErrorVerifyCodeIntent(error: AppTextConstants.pleaseEnterValidOtp),
      );
      return;
    }
    emit(state.copyWith(isVerifyOtpLoading: true));
    final request = VerifyCodeRequestModel(resetCode: state.otpCode);
    final response = await verifyCodeUseCase(request);
    response.when(
      initial: () => null,
      loading: () => null,
      success: (_) {
        emit(state.copyWith(isVerifyOtpLoading: false));
        _streamController.add(NavigateToResetPasswordIntent());
      },
      failure: (error) {
        emit(state.copyWith(isVerifyOtpLoading: false));
        _streamController.add(ShowErrorVerifyCodeIntent(error: error.message));
      },
    );
  }

  Future<void> _handleResendOtpCode(String email) async {
    emit(state.copyWith(isVerifyOtpLoading: true));
    final request = ForgetPasswordRequestModel(email: email);
    final response = await forgetPasswordUseCase(request);
    response.when(
      initial: () => null,
      loading: () => null,
      success: (_) {
        emit(state.copyWith(isVerifyOtpLoading: false));
        _streamController.add(
          ShowSuccessVerifyCodeIntent(
            message: AppTextConstants.otpSentSuccessfully,
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(isVerifyOtpLoading: false));
        _streamController.add(ShowErrorVerifyCodeIntent(error: error.message));
      },
    );
  }

  void _handleNewPasswordChanged(String newPassword) {
    emit(
      state.copyWith(
        newPassword: newPassword,
        isFormValid: _validateForm(
          newPassword: newPassword,
          confirmNewPassword: state.confirmNewPassword,
        ),
      ),
    );
  }

  void _handleConfirmNewPasswordChanged(String confirmNewPassword) {
    emit(
      state.copyWith(
        confirmNewPassword: confirmNewPassword,
        isFormValid: _validateForm(
          newPassword: state.newPassword,
          confirmNewPassword: confirmNewPassword,
        ),
      ),
    );
  }

  bool? _validateForm({
    required String newPassword,
    required String confirmNewPassword,
  }) {
    if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
      return null;
    }
    return newPassword.length >= 8 && newPassword == confirmNewPassword;
  }

  Future<void> _handleResetPassword() async {
    if (state.newPassword.isEmpty || state.confirmNewPassword.isEmpty) {
      _streamController.add(
        ShowErrorResetPasswordIntent(
          error: AppTextConstants.pleaseEnterValidPassword,
        ),
      );
      return;
    }
    if (state.newPassword.length < 8) {
      _streamController.add(
        ShowErrorResetPasswordIntent(
          error: AppTextConstants.thePasswordMustBeAtLeast8CharactersLong,
        ),
      );
      return;
    }
    if (state.newPassword != state.confirmNewPassword) {
      _streamController.add(
        ShowErrorResetPasswordIntent(
          error: AppTextConstants.confirmPasswordDoesNotMatch,
        ),
      );
      return;
    }
    emit(state.copyWith(isLoading: true));
    final request = ResetPasswordRequestModel(
      newPassword: state.newPassword,
      email: state.email,
    );
    final response = await resetPasswordUseCase(request);
    response.when(
      initial: () => null,
      loading: () => null,
      success: (_) {
        emit(state.copyWith(isLoading: false));
        _streamController.add(
          NavigateToLoginIntent(
            message: AppTextConstants.passwordResetSuccessfully,
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(isLoading: false));
        _streamController.add(
          ShowErrorResetPasswordIntent(error: error.message),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }
}
