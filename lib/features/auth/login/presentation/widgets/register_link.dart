import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class register_link extends StatelessWidget {
  const register_link({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Login',
          style: TextStyle(
            color: AppColors.white.withValues(alpha: .7),
            fontSize: 13,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'register',
            style: TextStyle(
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
