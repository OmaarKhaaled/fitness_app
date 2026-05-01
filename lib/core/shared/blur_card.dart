import 'dart:ui';
import '../theme/app_colors.dart';
import 'package:flutter/material.dart';

class BlurCard extends StatelessWidget {
  final Widget child;
  final double? height;

  const BlurCard({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: double.infinity,
            height: height,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: .008),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.white.withValues(alpha: .15)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
