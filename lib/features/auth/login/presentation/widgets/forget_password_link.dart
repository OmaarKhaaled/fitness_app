import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordLink extends StatelessWidget {
  const ForgetPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          context.pushNamed(AppRoutesConstants.forgetPasswordRoute);
        },
        child: Text(
          AppTextConstants.loginForgotPassword,
          style: TextStyle(
            color: AppColors.primary.withValues(alpha: .9),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
