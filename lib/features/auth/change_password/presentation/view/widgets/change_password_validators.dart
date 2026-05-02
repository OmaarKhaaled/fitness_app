import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/core/validators/app_regex.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_paasword_intent.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';

class ChangePasswordAppValidators {
  static String? validateAll({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      return 'Please fill all fields';
    }

    if (newPassword != confirmPassword) {
      return 'Confirm password does not match';
    }

    if (newPassword.trim() == oldPassword.trim()) {
      return 'New password must differ from old password';
    }

    if (newPassword.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!AppRegex.hasUpperCase(newPassword)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!AppRegex.hasSpecialCharacter(newPassword)) {
      return 'Password must contain at least one special character';
    }

    if (!AppRegex.hasNumber(newPassword)) {
      return 'Password must contain at least one number';
    }

    return null; // valid
  }
}

void handleChangePasswordSubmit({
  required BuildContext context,
  required ChangePasswordCubit cubit,
  required GlobalKey<FormState> formKey,
}) {
  final oldPass = cubit.oldPasswordController.text.trim();
  final newPass = cubit.newPasswordController.text.trim();
  final confirmPass = cubit.confirmPasswordController.text.trim();

  final error = ChangePasswordAppValidators.validateAll(
    oldPassword: oldPass,
    newPassword: newPass,
    confirmPassword: confirmPass,
  );

  if (error != null) {
    UiUtils.showErrorMsg(context, error);
    return;
  }

  FocusScope.of(context).unfocus();
  cubit.doIntent(SubmitChangePasswordIntent());
}
