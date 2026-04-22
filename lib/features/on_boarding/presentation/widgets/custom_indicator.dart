import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends StatefulWidget {
  const CustomIndicator({super.key, required this.currentPage});
  final int currentPage;
  @override
  State<CustomIndicator> createState() => _CustomIndicatorState();
}

class _CustomIndicatorState extends State<CustomIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        customDot(0, widget.currentPage),
        customDot(1, widget.currentPage),
        customDot(2, widget.currentPage),
      ],
    );
  }
}

Widget customDot(int index, int currentPage) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    width: index == currentPage ? 24 : 8,
    height: 8,
    decoration: BoxDecoration(
      color: index == currentPage ? AppColors.primary : AppColors.hint,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
