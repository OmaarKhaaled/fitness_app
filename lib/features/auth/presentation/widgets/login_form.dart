import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/presentation/manager/manager/login_intent.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:fitness_app/core/routing/route_names.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/presentation/manager/manager/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  bool _obscurePassword = true;
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
    final state = context.watch<LoginCubit>().state;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.white.withValues(alpha: .1)),
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: (widget.autoValidate ?? false)
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.login_heading.tr(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 30),

            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: LocaleKeys.email.tr(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                final emailRegex = RegExp(
                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$");
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password Field
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscurePassword,
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: LocaleKeys.password.tr(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),

            // Forgot Password Link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.push(RouteNames.forgetPassword),
                child: Text(
                  LocaleKeys.login_forgot_password.tr(),
                  style: TextStyle(
                    color: AppColors.primary.withValues(alpha: .9),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Divider OR Divider
            Row(
              children: [
                Expanded(
                    child: Divider(color: AppColors.white.withValues(alpha: .2), endIndent: 10)),
                Text(
                  LocaleKeys.login_or.tr(),
                  style: TextStyle(color: AppColors.white.withValues(alpha: .5), fontSize: 12),
                ),
                Expanded(
                    child: Divider(color: AppColors.white.withValues(alpha: .2), indent: 10)),
              ],
            ),

            const SizedBox(height: 24),

            // Social Logins
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.facebook, Colors.white.withValues(alpha: .1)),
                const SizedBox(width: 20),
                _buildSocialIcon(Icons.g_mobiledata, Colors.white.withValues(alpha: .15), size: 36),
                const SizedBox(width: 20),
                _buildSocialIcon(Icons.apple, Colors.white.withValues(alpha: .1)),
              ],
            ),

            const SizedBox(height: 32),

            // Login Button
            SizedBox(
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
            ),

            const SizedBox(height: 24),

            // Register Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.login_no_account.tr(),
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: .7),
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(RouteNames.register),
                  child: Text(
                    LocaleKeys.login_register_link.tr(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color, {double size = 24}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: size),
    );
  }
}
