import '../../../../core/constants/app_text_constants.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingNavigation extends StatefulWidget {
  const OnBoardingNavigation({
    super.key,
    required this.controller,
    required this.currentPage,
  });
  final PageController controller;
  final int currentPage;

  @override
  State<OnBoardingNavigation> createState() => _OnBoardingNavigationState();
}

class _OnBoardingNavigationState extends State<OnBoardingNavigation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: (widget.currentPage) == 0
          ? ElevatedButton(
              onPressed: () {
                widget.controller.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                AppTextConstants.onboardingNextButton,
                style: GoogleFonts.balooThambi2(
                  fontSize: 14,
                  color: AppColors.hint,
                  fontWeight: FontWeight.w800,
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
                  onPressed: () {
                    widget.controller.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
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
                        onPressed: () {
                          widget.controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
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
                        onPressed: () {},
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
