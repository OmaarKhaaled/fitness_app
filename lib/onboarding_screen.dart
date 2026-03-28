import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
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
              cursorColor: Colors.white,
              decoration: const InputDecoration(hintText: 'Enter your email'),
            ),
          ],
        ),
      ),
    );
  }
}
