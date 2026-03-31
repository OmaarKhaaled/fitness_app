import 'dart:ui';

import '../../../../core/constants/app_text_constants.dart';
import '../../../../core/theme/app_colors.dart';
import 'on_boarding_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingBottomSheet extends StatelessWidget {
  const OnBoardingBottomSheet({
    super.key,
    required this.controller,
    required this.currentPage,
  });
  final PageController controller;
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 34.6, sigmaY: 34.6),
        child: BottomSheet(
          constraints: const BoxConstraints(maxHeight: 275, minHeight: 275),
          backgroundColor: Colors.transparent,
          onClosing: () {},
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 31,
              ),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 275),
                    child: AnimatedSwitcher(
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
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      key: ValueKey(currentPage),
                      AppTextConstants.onBoardingSlideDescriptions[currentPage],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.balooThambi2(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                        letterSpacing: 0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SmoothPageIndicator(
                      effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                        dotColor: AppColors.hint,
                      ),
                      controller: controller,
                      count: 3,
                    ),
                  ),
                  OnBoardingNavigation(
                    controller: controller,
                    currentPage: currentPage,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
