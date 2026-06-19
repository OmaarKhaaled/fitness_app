import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view/widgets/change_password_screen.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChangePasswordCubit>(),
      child: const ChangePasswordScreen(),
    );
  }
}
