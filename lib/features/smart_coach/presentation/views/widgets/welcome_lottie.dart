import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeLottie extends StatelessWidget {
  const WelcomeLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AppAssets.welcomeLottie,
        fit: BoxFit.cover,
        repeat: false,
      ),
    );
  }
}
