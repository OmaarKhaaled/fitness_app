import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';

class OnBoardingPicsSection extends StatelessWidget {
  const OnBoardingPicsSection({super.key, required this.currentPage});
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Image.asset(
          key: ValueKey(currentPage),
          AppAssets.onBoardingSlides[currentPage],
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
