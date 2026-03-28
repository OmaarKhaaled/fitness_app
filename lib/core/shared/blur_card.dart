import 'dart:ui';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BlurCard extends StatelessWidget {
  final Widget child;
  final double? height;

  const BlurCard({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 34, sigmaY: 34),
          child: Container(
            width: double.infinity,
            height: height,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: .08),
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
