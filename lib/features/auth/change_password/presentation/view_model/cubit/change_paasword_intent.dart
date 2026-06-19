sealed class ChangePasswordIntent {
  const ChangePasswordIntent();

  static final toggleCurrentPasswordVisibility = ToggleOldPasswordVisibility();
  static final toggleNewPasswordVisibility = ToggleNewPasswordVisibility();
  static final toggleConfirmPasswordVisibility =
      ToggleConfirmPasswordVisibility();

  static final submit = SubmitChangePasswordIntent();
}

class ToggleOldPasswordVisibility extends ChangePasswordIntent {}

class ToggleNewPasswordVisibility extends ChangePasswordIntent {}

class ToggleConfirmPasswordVisibility extends ChangePasswordIntent {}

class SubmitChangePasswordIntent extends ChangePasswordIntent {}
