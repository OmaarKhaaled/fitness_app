
sealed class ChangePaaswordIntent {}

class FormChangedIntent extends ChangePaaswordIntent {
  final FormChangedIntent request;
  FormChangedIntent(this.request);
}

class ToggleCurrentPasswordVisibility extends ChangePaaswordIntent {}

class ToggleNewPasswordVisibility extends ChangePaaswordIntent {}

class ToggleConfirmPasswordVisibility extends ChangePaaswordIntent {}

class SubmitChangePasswordIntent extends ChangePaaswordIntent {}
