import '../theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final String backgroundImage;
  final Alignment alignment;
  final Widget? bottomWidget;
  final bool isBottomNavVisible;
  const AppScaffold({
    super.key,
    required this.child,
    required this.backgroundImage,
    this.alignment = Alignment.center,
    this.bottomWidget,
    this.isBottomNavVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(backgroundImage, fit: BoxFit.cover),
          Align(alignment: alignment, child: child),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: isBottomNavVisible ? null : 0,
        child: isBottomNavVisible ? bottomWidget : const SizedBox.shrink(),
      ),
    );
  }
}
