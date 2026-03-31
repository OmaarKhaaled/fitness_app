import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideDescription extends StatelessWidget {
  const SlideDescription({super.key, required this.currentPage});
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Text(
        key: UniqueKey(),
        AppTextConstants.onBoardingSlideDescriptions[currentPage],
        textAlign: TextAlign.center,
        style: GoogleFonts.balooThambi2(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          letterSpacing: 0,
        ),
      ),
    );
  }
}