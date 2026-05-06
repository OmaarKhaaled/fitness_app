import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterLink extends StatelessWidget {
  const RegisterLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppTextConstants.loginNoAccount,
          style: TextStyle(
            color: AppColors.white.withValues(alpha: .7),
            fontSize: 13,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            AppTextConstants.loginRegisterLink,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
