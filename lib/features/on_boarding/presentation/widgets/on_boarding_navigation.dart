import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_text_constants.dart';
import '../../../../core/theme/app_colors.dart';

class OnBoardingNavigation extends StatefulWidget {
  const OnBoardingNavigation({
    super.key,
    required this.currentPage,
    required this.onNextPressed,
    required this.onBackPressed,
    required this.onDoItPressed,
  });
  final int currentPage;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  final VoidCallback onDoItPressed;
  @override
  State<OnBoardingNavigation> createState() => _OnBoardingNavigationState();
}

class _OnBoardingNavigationState extends State<OnBoardingNavigation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: (widget.currentPage) == 0
          ? SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: widget.onNextPressed,
                child: Text(
                  AppTextConstants.onboardingNextButton,
                  style: GoogleFonts.balooThambi2(
                    fontSize: 14,
                    color: AppColors.hint,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    side: const BorderSide(width: 1, color: AppColors.primary),
                  ),
                  onPressed: widget.onBackPressed,
                  child: Text(
                    AppTextConstants.onboardingBackButton,
                    style: GoogleFonts.balooThambi2(
                      fontSize: 14,
                      color: AppColors.hint,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                (widget.currentPage) != 2
                    ? ElevatedButton(
                        onPressed: widget.onNextPressed,
                        child: Text(
                          AppTextConstants.onboardingNextButton,
                          style: GoogleFonts.balooThambi2(
                            fontSize: 14,
                            color: AppColors.hint,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: widget.onDoItPressed,
                        child: Text(
                          AppTextConstants.onboardingDoItButton,
                          style: GoogleFonts.balooThambi2(
                            fontSize: 14,
                            color: AppColors.hint,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
              ],
            ),
    );
  }
}
