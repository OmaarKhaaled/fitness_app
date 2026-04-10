import 'dart:ui';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final String backgroundImage;
  final Alignment alignment;
  const AppScaffold({
    super.key,
    required this.child,
    required this.backgroundImage,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(backgroundImage, fit: BoxFit.cover),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12.5, sigmaY: 12.5),
                child: Container(color: AppColors.black.withValues(alpha: .35)),
              ),
              Align(alignment: alignment, child: child),
            ],
          ),
        ),
      ),
    );
  }
}
