import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/routing/route_names.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/login/presentation/widgets/default_snackbar.dart';
import 'package:fitness_app/features/change_password/presentation/view/widgets/change_password_form.dart';
import 'package:fitness_app/features/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController passwordController;

  const ChangePasswordScreen({
    super.key,
    this.formKey,
    required this.passwordController,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (p, c) => p.baseState != c.baseState,
      listener: (context, state) {
        if (state.baseState.data != null && !state.baseState.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            defaultSnackBar(
              message: AppTextConstants.passwordResetSuccessfully,
              color: AppColors.green,
            ),
          );
          context.push(RouteNames.login);
        }
      },
      builder: (context, state) {
        return const ChangePasswordForm();
      },
    );
  }
}
