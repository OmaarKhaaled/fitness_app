import 'package:fitness_app/features/change_password/data/models/request/change_password_request.dart';

sealed class ChangePaaswordIntent {}

class FormChangedIntent extends ChangePaaswordIntent {
  final ChangePasswordRequest? request;
  FormChangedIntent([this.request]);
}

class ToggleCurrentPasswordVisibility extends ChangePaaswordIntent {}

class ToggleNewPasswordVisibility extends ChangePaaswordIntent {}

class ToggleConfirmPasswordVisibility extends ChangePaaswordIntent {}

class SubmitChangePasswordIntent extends ChangePaaswordIntent {}
