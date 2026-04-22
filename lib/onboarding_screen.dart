import 'core/constants/app_assets.dart';
import 'core/shared/app_scaffold.dart';
import 'core/shared/blur_card.dart';
import 'core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    // test
    return AppScaffold(
      backgroundImage: AppAssets.authBackground,
      child: BlurCard(
        child: Column(
          children: [
            TextFormField(
              cursorColor: AppColors.white,
              decoration: const InputDecoration(hintText: 'Enter your email'),
            ),
          ],
        ),
      ),
    );
  }
}
