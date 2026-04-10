import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RadioOptionSelectionWidget extends StatelessWidget {
  final String option;
  final VoidCallback onTap;
  final bool isSelected;
  const RadioOptionSelectionWidget({
    super.key,
    required this.option,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      width: double.infinity,
      height: 0.045 * height,
      padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
      margin: EdgeInsets.symmetric(horizontal: 0.09 * width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.05 * width),
        border: Border.all(width: 1, color: AppColors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            option,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 0.05 * width,
              height: 0.05 * width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: AppColors.white),
              ),
              child: isSelected
                  ? Padding(
                      padding: EdgeInsets.all(0.01 * width),
                      child: Container(
                        width: 0.04 * width,
                        height: 0.04 * width,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
