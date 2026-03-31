import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class OnBoardingPicsSection extends StatelessWidget {
  const OnBoardingPicsSection({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: 3, // Replace with actual number of slides
        itemBuilder: (context, index) {
          return FadeInImage(
            placeholder: const AssetImage(
              AppAssets.onboarding1,
            ), // A transparent image as a placeholder
            image: AssetImage(AppAssets.onBoardingSlides[index]),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
