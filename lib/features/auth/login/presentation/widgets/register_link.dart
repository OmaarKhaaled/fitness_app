import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class RegisterLink extends StatelessWidget {
  const RegisterLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onTap: () {},
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
    );
  }
}
