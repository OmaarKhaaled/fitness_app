import 'package:fitness_app/config/base_state/base_state.dart';

class ForgetPasswordStates extends BaseState<void> {
  // provide email states
  final String email;
  final bool isEmailValid;
  final bool isSendOtpLoading;

  // verify otp states
  final String otpCode;
  final bool isOtpCodeValid;
  final bool isVerifyOtpLoading;

  // reset password states
  final String newPassword;
  final String confirmNewPassword;
  final bool isFormValid;

  const ForgetPasswordStates({
    super.isLoading = false,
    super.errorMessage,
    this.email = '',
    this.isEmailValid = false,
    this.isSendOtpLoading = false,
    this.otpCode = '',
    this.isOtpCodeValid = false,
    this.isVerifyOtpLoading = false,
    this.newPassword = '',
    this.confirmNewPassword = '',
    this.isFormValid = false,
  });

  @override
  ForgetPasswordStates copyWith({
    void data,
    bool? isLoading,
    String? errorMessage,
    String? email,
    bool? isEmailValid,
    bool? isSendOtpLoading,
    String? otp,
    bool? isOtpValid,
    bool? isVerifyOtpLoading,
    String? newPassword,
    String? confirmNewPassword,
    bool? isFormValid,
  }) {
    return ForgetPasswordStates(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSendOtpLoading: isSendOtpLoading ?? this.isSendOtpLoading,
      otpCode: otp ?? this.otpCode,
      isOtpCodeValid: isOtpValid ?? this.isOtpCodeValid,
      isVerifyOtpLoading: isVerifyOtpLoading ?? this.isVerifyOtpLoading,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    email,
    isEmailValid,
    isSendOtpLoading,
    otpCode,
    isOtpCodeValid,
    isVerifyOtpLoading,
    newPassword,
    confirmNewPassword,
    isFormValid,
  ];
}
