import 'dart:async';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_intents.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_states.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_ui_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  StreamSubscription? _streamSubscription;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _streamSubscription = context
          .read<ForgetPasswordCubit>()
          .uiIntents
          .listen((event) {
            switch (event) {
              case ShowErrorResetPasswordIntent():
                UiUtils.showErrorMsg(context, event.error);
              case NavigateToLoginIntent():
                UiUtils.showSuccessMsg(context, event.message);
                context.pop();
              case _:
                break;
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTextConstants.makeSureIts8CharactersOrMore,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppTextConstants.createNewPassword,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        BlurCard(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    context.read<ForgetPasswordCubit>().doIntent(
                      NewPasswordChangedIntent(newPassword: value),
                    );
                  },
                  cursorColor: AppColors.white,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.white,
                      size: 25,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.white,
                        size: 22,
                      ),
                    ),
                    hintText: AppTextConstants.newPassword,
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    context.read<ForgetPasswordCubit>().doIntent(
                      ConfirmNewPasswordChangedIntent(
                        confirmNewPassword: value,
                      ),
                    );
                  },
                  cursorColor: AppColors.white,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.white,
                      size: 25,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(
                          () => _obscureConfirmPassword =
                              !_obscureConfirmPassword,
                        );
                      },
                      child: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.white,
                        size: 22,
                      ),
                    ),
                    hintText: AppTextConstants.confirmPassword,
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 45,
                child:
                    BlocSelector<
                      ForgetPasswordCubit,
                      ForgetPasswordStates,
                      bool
                    >(
                      selector: (state) => state.isLoading,
                      builder: (context, isLoading) {
                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<ForgetPasswordCubit>().doIntent(
                                    ResetPasswordIntent(),
                                  );
                                },
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.white,
                                  ),
                                )
                              : Text(
                                  AppTextConstants.done,
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        );
                      },
                    ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }
}
