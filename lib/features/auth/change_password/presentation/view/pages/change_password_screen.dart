import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/routing/route_names.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view/widgets/change_password_form.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordCubit>(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listenWhen: (p, c) => p.baseState != c.baseState,
        listener: (context, state) {
          if (state.baseState.data != null && !state.baseState.isLoading) {
            UiUtils.showSuccessMsg(
              context,
              AppTextConstants.passwordResetSuccessfully,
            );
            context.push(RouteNames.login);
          }
          if (state.baseState.errorMessage != null &&
              !state.baseState.isLoading) {
            UiUtils.showErrorMsg(context, state.baseState.errorMessage!);
          }
        },
        builder: (context, state) {
          return const ChangePasswordForm();
        },
      ),
    );
  }
}
