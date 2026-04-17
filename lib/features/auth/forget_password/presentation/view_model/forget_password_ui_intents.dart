class ForgetPasswordUiIntents {
  ForgetPasswordUiIntents();
}

// Provide Email Intents

class ShowLoadingProvideEmailIntent extends ForgetPasswordUiIntents {}

class HideLoadingProvideEmailIntent extends ForgetPasswordUiIntents {}

class ShowErrorProvideEmailIntent extends ForgetPasswordUiIntents {
  final String error;
  ShowErrorProvideEmailIntent({required this.error});
}

class NavigateToVerifyCodeIntent extends ForgetPasswordUiIntents {}

// Verify Code Intents

class ShowLoadingVerifyCodeIntent extends ForgetPasswordUiIntents {}

class HideLoadingVerifyCodeIntent extends ForgetPasswordUiIntents {}

class ShowErrorVerifyCodeIntent extends ForgetPasswordUiIntents {
  final String error;
  ShowErrorVerifyCodeIntent({required this.error});
}

class ShowSuccessVerifyCodeIntent extends ForgetPasswordUiIntents {
  final String message;
  ShowSuccessVerifyCodeIntent({required this.message});
}

class NavigateToResetPasswordIntent extends ForgetPasswordUiIntents {}

// Reset Password Intents

class ShowLoadingResetPasswordIntent extends ForgetPasswordUiIntents {}

class HideLoadingResetPasswordIntent extends ForgetPasswordUiIntents {}

class ShowErrorResetPasswordIntent extends ForgetPasswordUiIntents {
  final String error;
  ShowErrorResetPasswordIntent({required this.error});
}

class NavigateToLoginIntent extends ForgetPasswordUiIntents {
  final String message;
  NavigateToLoginIntent({required this.message});
}
