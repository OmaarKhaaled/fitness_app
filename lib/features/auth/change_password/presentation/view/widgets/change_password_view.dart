import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view/widgets/change_password_textfield.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view/widgets/change_password_validators.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_paasword_intent.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundImage: AppAssets.authBackground,
      blurSigma: 10,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        leading: InkWell(
          onTap: () => context.go('/home'),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Icon(Icons.arrow_back, color: AppColors.primary, size: 35),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AppAssets.fitness, height: 75, width: 90),
        ),
      ),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state.baseState.errorMessage != null) {
            UiUtils.showErrorMsg(context, state.baseState.errorMessage!);
          }

          if (state.baseState.data != null) {
            UiUtils.showSuccessMsg(context, state.baseState.data!.message);
            context.go(AppRoutesConstants.homeRoute);
          }
        },
        builder: (context, state) {
          final cubit = context.read<ChangePasswordCubit>();

          return Form(
            key: cubit.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlurCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChangePasswordTextField(
                      controller: cubit.oldPasswordController,
                      hintText: AppTextConstants.oldPassword,
                      obscureText: state.oldPasswordVisible,
                      onToggleVisibility: () =>
                          cubit.doIntent(ToggleOldPasswordVisibility()),
                      validator: AppValidators.validateRequired,
                    ),
                    const SizedBox(height: 12),

                    ChangePasswordTextField(
                      controller: cubit.newPasswordController,
                      hintText: AppTextConstants.newPassword,
                      obscureText: state.newPasswordVisible,
                      onToggleVisibility: () =>
                          cubit.doIntent(ToggleNewPasswordVisibility()),
                    ),
                    const SizedBox(height: 12),

                    ChangePasswordTextField(
                      controller: cubit.confirmPasswordController,
                      hintText: AppTextConstants.confirmPassword,
                      obscureText: state.confirmPasswordVisible,
                      onToggleVisibility: () =>
                          cubit.doIntent(ToggleConfirmPasswordVisibility()),
                      validator: AppValidators.validateRequired,
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.baseState.isLoading
                            ? null
                            : () => handleChangePasswordSubmit(
                                context: context,
                                cubit: cubit,
                                formKey: cubit.formKey,
                              ),
                        child: state.baseState.isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Done'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
