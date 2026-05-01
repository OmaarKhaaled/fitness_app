import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_paasword_intent.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);


    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return AppScaffold(
          backgroundImage: AppAssets.authBackground,
          hasGradient: true,
          appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: mediaQueryData.size.height * 0.07,
            children: [
              Image.asset(
                AppAssets.fitness,
                height: mediaQueryData.size.height * 0.15,
                width: mediaQueryData.size.height * 0.15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlurCard(
                  child: Column(
                    spacing: MediaQuery.of(context).size.height * 0.03,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTextConstants.makeSureIts8CharactersOrMore,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        AppTextConstants.createNewPassword,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ChangePasswordTextField(
                        controller: context
                            .read<ChangePasswordCubit>()
                            .currentPasswordController,
                        hintText: AppTextConstants.oldPassword,
                      ),
                      ChangePasswordTextField(
                        controller: context
                            .read<ChangePasswordCubit>()
                            .newPasswordController,
                        hintText: AppTextConstants.newPassword,
                      ),
                      ChangePasswordTextField(
                        controller: context
                            .read<ChangePasswordCubit>()
                            .confirmPasswordController,
                        hintText: AppTextConstants.confirmPassword,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () {
                            context.read<ChangePasswordCubit>().doIntent(
                              SubmitChangePasswordIntent(),
                            );
                          },
                          child: Text(AppTextConstants.done),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChangePasswordTextField extends StatelessWidget {
  const ChangePasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outlined, color: AppColors.grey),
        suffixIcon: const Icon(
          Icons.visibility_outlined,
          color: AppColors.grey,
        ),
        hintText: hintText,
      ),
    );
  }
}
