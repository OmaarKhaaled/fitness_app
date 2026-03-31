import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_text_constants.dart';
import '../../../../core/theme/app_colors.dart';

class SlideTitle extends StatelessWidget {
  const SlideTitle({super.key, required this.currentPage});
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Text(
        key: ValueKey(currentPage),
        AppTextConstants.onBoardingSlideTitles[currentPage],
        textAlign: TextAlign.center,
        style: GoogleFonts.balooThambi2(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: AppColors.white,
          letterSpacing: 0,
        ),
      ),
    );
  }
}