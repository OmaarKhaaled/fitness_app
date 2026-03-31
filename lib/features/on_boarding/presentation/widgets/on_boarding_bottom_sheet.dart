import 'dart:ui';

import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/on_boarding/presentation/widgets/on_boarding_navigation.dart';
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
        filter: ImageFilter.blur(
          sigmaX: 34.6,
          sigmaY: 34.6,
          tileMode: TileMode.mirror,
        ),
        child: BottomSheet(
          enableDrag: false,
          constraints: BoxConstraints(
            maxHeight: 275,
            minHeight: 275,
            minWidth: MediaQuery.of(context).size.width,
          ),
          backgroundColor: Colors.transparent,
          onClosing: () {},
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 31.5,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                        maxHeight: 68,
                      ),
                      child: Text(
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
                    Text(
                      AppTextConstants.onBoardingSlideDescriptions[controller
                              .page
                              ?.toInt() ??
                          0],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.balooThambi2(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                        letterSpacing: 0,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: SmoothPageIndicator(
                        onDotClicked: null,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
