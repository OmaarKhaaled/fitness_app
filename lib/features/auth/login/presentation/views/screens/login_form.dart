import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/features/auth/login/presentation/manager/manager/login_states.dart';
import 'package:fitness_app/features/auth/login/presentation/widgets/default_snackbar.dart';
import 'package:fitness_app/features/auth/login/presentation/widgets/email_textfield.dart';
import 'package:fitness_app/features/auth/login/presentation/widgets/forget_password_link.dart';
import 'package:fitness_app/features/auth/login/presentation/widgets/login_button.dart';
import 'package:fitness_app/features/auth/login/presentation/widgets/password_textfield.dart';
import 'package:fitness_app/features/auth/login/presentation/widgets/register_link.dart';
import 'package:fitness_app/features/auth/login/presentation/widgets/social_login_buttons.dart';
import 'package:fitness_app/core/routing/route_names.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/login/presentation/manager/manager/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rename_app/utils.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final bool? autoValidate;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  const LoginForm({
    super.key,
    this.formKey,
    this.autoValidate,
    this.emailController,
    this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey ?? GlobalKey<FormState>();
    _emailController = widget.emailController ?? TextEditingController();
    _passwordController = widget.passwordController ?? TextEditingController();
    _rememberMe = context.read<LoginCubit>().state.rememberMe;
  }

  @override
  void dispose() {
    if (widget.emailController == null) _emailController.dispose();
    if (widget.passwordController == null) _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return BlocListener<LoginCubit, LoginStates>(
      listenWhen: (previous, current) =>
          previous.loginResource != current.loginResource,
      listener: (context, state) {
        state.loginResource.whenOrNull(
          success: (data) {
            Utils.logMessage('Login success: ${data.message}');
            context.go(RouteNames.home);
          },
          failure: (exception) {
            ScaffoldMessenger.of(context).showSnackBar(
              defaultSnackBar(
                message: exception.message,
                color: AppColors.redAccent,
              ),
            );
          },
        );
      },
      child: BlurCard(
        child: Form(
          key: _formKey,
          autovalidateMode: (widget.autoValidate ?? false)
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppTextConstants.loginHeading,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Email Field
              EmailTextField(emailController: _emailController),
              const SizedBox(height: 16),

              // Password Field
              PasswordTextField(
                controller: _passwordController,
                hintText: AppTextConstants.loginEmailPlaceholder,
              ),

              // Forgot Password Link
              const ForgetPasswordLink(),

              const SizedBox(height: 10),

              // Divider OR Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.white.withValues(alpha: .2),
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    AppTextConstants.loginOr,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: .5),
                      fontSize: 12,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.white.withValues(alpha: .2),
                      indent: 10,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Social Logins
              const SocialLoginButtons(),

              const SizedBox(height: 32),

              // Login Button
              LoginButton(
                formKey: _formKey,
                cubit: cubit,
                emailController: _emailController,
                passwordController: _passwordController,
                rememberMe: _rememberMe,
              ),

              const SizedBox(height: 24),

              // Register Link
              const RegisterLink(),
            ],
          ),
        ),
      ),
    );
  }
}
