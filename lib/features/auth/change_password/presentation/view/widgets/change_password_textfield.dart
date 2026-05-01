import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:flutter/material.dart';

class ChangePasswordTextField extends StatelessWidget {
  const ChangePasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onToggleVisibility,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: AppColors.grey,
        ),
        hintText: hintText,
        suffixIcon: IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.grey,
            size: 20,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
      validator:AppValidators.validatePassword,
    );
  }
}