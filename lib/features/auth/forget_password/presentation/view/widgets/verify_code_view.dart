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
import 'package:pinput/pinput.dart';

class VerifyCodeView extends StatefulWidget {
  final String email;
  final VoidCallback onNext;
  const VerifyCodeView({super.key, required this.email, required this.onNext});

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final TextEditingController _otpController = TextEditingController();
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    _otpController.dispose();
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
              case ShowErrorVerifyCodeIntent():
                UiUtils.showErrorMsg(context, event.error);
              case ShowSuccessVerifyCodeIntent():
                UiUtils.showSuccessMsg(context, event.message);
              case NavigateToResetPasswordIntent():
                widget.onNext();
              case _:
                break;
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: textTheme.bodyLarge?.copyWith(
        fontSize: 22,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.white, width: 2)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.primary, width: 3)),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: textTheme.bodyLarge?.copyWith(
        fontSize: 22,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withValues(alpha: .8),
            width: 2,
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTextConstants.otpCode,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppTextConstants.otpCodeDescription,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        BlurCard(
          child: Column(
            children: [
              Pinput(
                controller: _otpController,
                length: 6,
                pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                cursor: Container(
                  width: 2,
                  height: 24,
                  color: AppColors.primary,
                ),
                onChanged: (value) {
                  context.read<ForgetPasswordCubit>().doIntent(
                    OtpCodeChangedIntent(otpCode: value),
                  );
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 45,
                child:
                    BlocSelector<
                      ForgetPasswordCubit,
                      ForgetPasswordStates,
                      bool
                    >(
                      selector: (state) => state.isVerifyOtpLoading,
                      builder: (context, isLoading) {
                        return ElevatedButton(
                          onPressed: () {
                            if (isLoading) return;
                            context.read<ForgetPasswordCubit>().doIntent(
                              ConfirmOtpCodeIntent(),
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
                                  AppTextConstants.confirm,
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        );
                      },
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                AppTextConstants.didntRecieveVerificationCode,
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  context.read<ForgetPasswordCubit>().doIntent(
                    ResendOtpCodeIntent(email: widget.email),
                  );
                },
                child: Text(
                  AppTextConstants.resendCode,
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ],
    );
  }
}
