
// import 'package:fitness_app/core/theme/app_colors.dart';
// import 'package:flutter/material.dart';

// class ChangePasswordTextField extends StatelessWidget {
//   const ChangePasswordTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//    required this.isPasswordVisible ,
//     required this.onChanged,
//   });

//   final TextEditingController controller;
//   final String hintText;
//   final bool isPasswordVisible;
//   final Function(String) onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPasswordVisible,
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.lock_outlined, color: AppColors.grey),
//         suffixIcon: isPasswordVisible
//             ? const Icon(Icons.vibration_outlined, color: AppColors.grey)
//             : const Icon(Icons.visibility_off_outlined, color: AppColors.grey),
//         hintText: hintText,
//       ),
//     );
//   }
// }
