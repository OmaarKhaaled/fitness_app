import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/change_password/presentation/view_model/cubit/change_paasword_intent.dart';
import 'package:fitness_app/features/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              controller: context
                  .read<ChangePasswordCubit>()
                  .currentPasswordController,
              decoration: InputDecoration(
                hintText: AppTextConstants.currentPassword,
              ),
            ),
            TextFormField(
              controller: context.read<ChangePasswordCubit>().newPasswordController,
              decoration: InputDecoration(
                hintText: AppTextConstants.newPassword,
              ),
            ),
            TextFormField(
              controller: context.read<ChangePasswordCubit>().confirmPasswordController,
              decoration: InputDecoration(
                hintText: AppTextConstants.confirmPassword,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ChangePasswordCubit>().doIntent(SubmitChangePasswordIntent());
              },
              child: Text(AppTextConstants.done),
            ),
          ],
        );
      },
    );
  }
}
