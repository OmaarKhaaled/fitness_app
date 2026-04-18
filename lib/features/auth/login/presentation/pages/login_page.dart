import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/features/auth/login/presentation/manager/manager/login_cubit.dart';
import 'package:fitness_app/features/auth/login/presentation/widgets/login_form.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: AppScaffold(
        backgroundImage: AppAssets.authBackground,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // App Logo
              SvgPicture.asset(AppIcons.superFitness, height: 100),
              const SizedBox(height: 40),
              // Welcome Text
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.login_greeting.tr(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      LocaleKeys.login_welcome_back.tr(),
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const LoginForm(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
