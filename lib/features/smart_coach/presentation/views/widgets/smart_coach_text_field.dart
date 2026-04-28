import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SmartCoachTextField extends StatelessWidget {
  const SmartCoachTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: TextField(
            cursorColor: AppColors.white,
            decoration: InputDecoration(
              hintText: AppTextConstants.askSmartCoach,
              hintStyle: textTheme.bodyLarge?.copyWith(
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
            textInputAction: TextInputAction.send,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            onSubmitted: (value) {},
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.send, color: AppColors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}
