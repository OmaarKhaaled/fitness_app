import 'dart:ui';
import '../theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final String backgroundImage;
  final Alignment alignment;
  final Widget? bottomWidget;
  final bool isBottomNavVisible;
  final bool hasGradient;
  final PreferredSizeWidget? appBar;
  final double blurSigma;

  const AppScaffold({
    super.key,
    required this.child,
    required this.backgroundImage,
    this.alignment = Alignment.center,
    this.bottomWidget,
    this.isBottomNavVisible = true,
    this.hasGradient = false,
    this.appBar,
    this.blurSigma = 0.0, // Default to no blur
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.transparent,
      appBar: appBar,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image
          Image.asset(backgroundImage, fit: BoxFit.cover),

          // 2. Optional Blur
          if (blurSigma > 0)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: const SizedBox.expand(),
            ),

          // 3. Optional Gradient
          if (hasGradient)
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.black,
                      AppColors.navBarBg,
                    ],
                  ),
                ),
              ),
            ),

          // 4. Content
          Align(alignment: alignment, child: child),
        ],
      ),
      bottomNavigationBar: bottomWidget == null
          ? null
          : AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: isBottomNavVisible ? null : 0,
              child: isBottomNavVisible
                  ? bottomWidget
                  : const SizedBox.shrink(),
            ),
    );
  }
}
