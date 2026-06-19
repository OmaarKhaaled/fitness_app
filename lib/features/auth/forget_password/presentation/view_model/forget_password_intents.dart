sealed class ForgetPasswordIntents {}

// provide email view intents
class EmailChangedIntent extends ForgetPasswordIntents {
  final String email;
  EmailChangedIntent({required this.email});
}

class SendOtpIntent extends ForgetPasswordIntents {}

// otp view intents
class OtpCodeChangedIntent extends ForgetPasswordIntents {
  final String otpCode;
  OtpCodeChangedIntent({required this.otpCode});
}

class ConfirmOtpCodeIntent extends ForgetPasswordIntents {}

class ResendOtpCodeIntent extends ForgetPasswordIntents {
  final String email;
  ResendOtpCodeIntent({required this.email});
}

// reset password view intents
class NewPasswordChangedIntent extends ForgetPasswordIntents {
  final String newPassword;
  NewPasswordChangedIntent({required this.newPassword});
}

class ConfirmNewPasswordChangedIntent extends ForgetPasswordIntents {
  final String confirmNewPassword;
  ConfirmNewPasswordChangedIntent({required this.confirmNewPassword});
}

class ResetPasswordIntent extends ForgetPasswordIntents {}
