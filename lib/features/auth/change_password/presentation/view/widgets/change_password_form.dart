import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/routing/route_names.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/core/validators/app_regex.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view/widgets/change_password_textfield.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_paasword_intent.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final cubit = context.read<ChangePasswordCubit>();
    final formKey = GlobalKey<FormState>();

    void showError(String message) {
      UiUtils.showErrorMsg(context, message);
    }

    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return AppScaffold(
          backgroundImage: AppAssets.authBackground,
          hasGradient: true,
          appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: mediaQueryData.size.height * 0.07,
            children: [
              Image.asset(
                AppAssets.fitness,
                height: mediaQueryData.size.height * 0.15,
                width: mediaQueryData.size.height * 0.15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlurCard(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Column(
                      spacing: mediaQueryData.size.height * 0.03,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTextConstants.makeSureIts8CharactersOrMore,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          AppTextConstants.createNewPassword,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        /// Current Password
                        ChangePasswordTextField(
                          controller: cubit.currentPasswordController,
                          hintText: AppTextConstants.oldPassword,
                          obscureText: state.currentPasswordVisible,
                          onToggleVisibility: () {
                            cubit.doIntent(ToggleCurrentPasswordVisibility());
                          },
                          validator: AppValidators.validateLoginPassword,
                        ),

                        /// New Password
                        ChangePasswordTextField(
                          controller: cubit.newPasswordController,
                          hintText: AppTextConstants.newPassword,
                          obscureText: state.newPasswordVisible,
                          onToggleVisibility: () {
                            cubit.doIntent(ToggleNewPasswordVisibility());
                          },
                          validator: (value) {
                            final result = AppValidators.validatePassword(
                              value,
                            );

                            if (result != null) {
                              return result;
                            }

                            if (value == cubit.currentPasswordController.text) {
                              return 'New password must differ from current password';
                            }

                            return null;
                          },
                        ),

                        /// Confirm Password
                        ChangePasswordTextField(
                          controller: cubit.confirmPasswordController,
                          hintText: AppTextConstants.confirmPassword,
                          obscureText: state.confirmPasswordVisible,
                          onToggleVisibility: () {
                            cubit.doIntent(ToggleConfirmPasswordVisibility());
                          },
                          validator: (value) {
                            return AppValidators.validateConfirmPassword(
                              value,
                              cubit.newPasswordController.text,
                            );
                          },
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();

                              final current = cubit
                                  .currentPasswordController
                                  .text
                                  .trim();

                              final newPass = cubit.newPasswordController.text
                                  .trim();

                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              if (current == newPass) {
                                showError(
                                  'New password cannot be same as current password',
                                );
                                return;
                              }

                              if (!AppRegex.hasUpperCase(newPass)) {
                                showError('Password needs uppercase letter');
                                return;
                              }

                              if (!AppRegex.hasSpecialCharacter(newPass)) {
                                showError('Password needs special character');
                                return;
                              }

                              if (formKey.currentState!.validate()) {
                                cubit.currentPasswordController.clear();
                                cubit.newPasswordController.clear();
                                cubit.confirmPasswordController.clear();

                                formKey.currentState!.reset();

                                FocusScope.of(context).unfocus();

                                cubit.doIntent(SubmitChangePasswordIntent());
                                UiUtils.showSuccessMsg(context, AppTextConstants.passwordResetSuccessfully);

                                // navigate back
                                context.go(RouteNames.home);
                              }
                            },
                            child: Text(AppTextConstants.done),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
