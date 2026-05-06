import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GenderSelectionWidget extends StatelessWidget {
  final String genderIconPath;
  final String genderName;
  final bool isSelected;
  final VoidCallback onTap;
  const GenderSelectionWidget({
    super.key,
    required this.genderIconPath,
    required this.genderName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 0.25 * width,
        height: 0.25 * width,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: isSelected ? AppColors.primary : AppColors.white,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 0.01 * height),
            Image.asset(genderIconPath, color: AppColors.white),
            SizedBox(height: 0.01 * height),
            Text(
              genderName,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
