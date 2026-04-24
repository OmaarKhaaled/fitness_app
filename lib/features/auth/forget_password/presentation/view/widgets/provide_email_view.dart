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

class ProvideEmailView extends StatefulWidget {
  final Function(String) onNext;
  const ProvideEmailView({super.key, required this.onNext});

  @override
  State<ProvideEmailView> createState() => _ProvideEmailViewState();
}

class _ProvideEmailViewState extends State<ProvideEmailView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    _emailController.dispose();
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
              case ShowErrorProvideEmailIntent():
                UiUtils.showErrorMsg(context, event.error);
              case NavigateToVerifyCodeIntent():
                widget.onNext(_emailController.text);
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
          AppTextConstants.enterYourEmail,
          style: textTheme.titleLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppTextConstants.forgetPassword,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        BlurCard(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _emailController,
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          context.read<ForgetPasswordCubit>().doIntent(
                            EmailChangedIntent(email: value.toLowerCase()),
                          );
                        },
                        cursorColor: AppColors.white,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppColors.white,
                            size: 25,
                          ),
                          hintText: AppTextConstants.email,
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
                            selector: (state) => state.isSendOtpLoading,
                            builder: (context, isLoading) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (isLoading) return;
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<ForgetPasswordCubit>()
                                        .doIntent(SendOtpIntent());
                                  }
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
                                        AppTextConstants.sendOtp,
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontSize: 18,
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
          ),
        ),
      ],
    );
  }
}
