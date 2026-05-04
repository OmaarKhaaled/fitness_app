import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view/widgets/change_password_textfield.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_paasword_intent.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return AppScaffold(
      backgroundImage: AppAssets.authBackground,
      blurSigma: 10,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        toolbarHeight: mediaQuery.size.height * 0.13,
        leading: InkWell(
          onTap: () => context.go(AppRoutesConstants.homeRoute),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 35,
          ),
        ),
        title: SizedBox(
          child: Image.asset(
            AppAssets.fitness,
            height: mediaQuery.size.height * 0.08,
          ),
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

          return Padding(
            padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTextConstants.createNewPassword,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.white),
                ),
                Text(
                  AppTextConstants.makeSureIts8CharactersOrMore,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.white),
                ),

                Form(
                  key: cubit.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.05,
                    ),
                    child: BlurCard(
                      child: Column(
                        children: [
                          /// OLD PASSWORD
                          TextFormField(
                            controller: cubit.oldPasswordController,
                            obscureText: !state.oldPasswordVisible,
                            validator: (value) => value.validatePassword,
                            decoration: InputDecoration(
                              hintText: AppTextConstants.oldPassword,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.oldPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () => cubit
                                    .doIntent(ToggleOldPasswordVisibility()),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// NEW PASSWORD
                          TextFormField(
                            controller: cubit.newPasswordController,
                            obscureText: !state.newPasswordVisible,
                            validator: (value) => value.validatePassword,
                            decoration: InputDecoration(
                              hintText: AppTextConstants.newPassword,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.newPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () => cubit
                                    .doIntent(ToggleNewPasswordVisibility()),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// CONFIRM PASSWORD
                          TextFormField(
                            controller: cubit.confirmPasswordController,
                            obscureText: !state.confirmPasswordVisible,
                            validator: (value) => value.validateMatch(
                              cubit.newPasswordController.text,
                            ),
                            decoration: InputDecoration(
                              hintText: AppTextConstants.confirmPassword,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.confirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () => cubit.doIntent(
                                  ToggleConfirmPasswordVisibility(),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// SUBMIT BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final isValid = cubit.formKey.currentState
                                        ?.validate() ??
                                    false;

                                if (isValid) {
                                  cubit.doIntent(
                                      SubmitChangePasswordIntent());
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
      ),
    );
  }
}