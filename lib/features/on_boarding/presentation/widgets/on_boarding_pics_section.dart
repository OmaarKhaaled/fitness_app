import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class OnBoardingPicsSection extends StatelessWidget {
  const OnBoardingPicsSection({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Image.asset(
            key: ValueKey(index),
            AppAssets.onBoardingSlides[index],
            width: double.infinity,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
