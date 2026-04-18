import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/login/presentation/manager/manager/login_cubit.dart';
import 'package:fitness_app/features/auth/login/presentation/manager/manager/login_intent.dart';
import 'package:fitness_app/features/auth/login/presentation/manager/manager/login_states.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required bool rememberMe,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        _rememberMe = rememberMe;

  final GlobalKey<FormState> _formKey;
  final LoginCubit cubit;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final bool _rememberMe;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      buildWhen: (previous, current) =>
          previous.loginResource != current.loginResource,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              elevation: 0,
            ),
            onPressed: state.loginResource.maybeWhen(
                loading: () => null,
                orElse: () => () {
                      if (_formKey.currentState!.validate()) {
                        cubit.doIntent(
                          PerformLogin(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            rememberMe: _rememberMe,
                          ),
                        );
                      }
                    }),
            child: state.loginResource.maybeWhen(
              loading: () => const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              ),
              orElse: () => Text(
                LocaleKeys.login_button.tr(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
