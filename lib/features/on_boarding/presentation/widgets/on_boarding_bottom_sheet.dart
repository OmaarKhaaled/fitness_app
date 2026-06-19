import 'dart:ui';

import 'package:fitness_app/features/on_boarding/presentation/widgets/custom_indicator.dart';
import 'package:fitness_app/features/on_boarding/presentation/widgets/slide_description.dart';
import 'package:fitness_app/features/on_boarding/presentation/widgets/slide_title.dart';
import 'package:flutter/material.dart';

import 'on_boarding_navigation.dart';

class OnBoardingBottomSheet extends StatefulWidget {
  const OnBoardingBottomSheet({
    super.key,
    required this.currentPage,
    required this.onNextPressed,
    required this.onBackPressed,
    required this.onDoItPressed,
  });
  final int currentPage;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  final VoidCallback onDoItPressed;

  @override
  State<OnBoardingBottomSheet> createState() => _OnBoardingBottomSheetState();
}

class _OnBoardingBottomSheetState extends State<OnBoardingBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 34.6, sigmaY: 34.6),
        child: BottomSheet(
          enableDrag: false,
          constraints: const BoxConstraints(maxHeight: 275, minHeight: 275),
          backgroundColor: Colors.transparent,
          onClosing: () {},
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SlideTitle(currentPage: widget.currentPage),
                    const SizedBox(height: 8),
                    SlideDescription(currentPage: widget.currentPage),
                    const SizedBox(height: 16),
                    CustomIndicator(currentPage: widget.currentPage),
                    const SizedBox(height: 20),
                    OnBoardingNavigation(
                      currentPage: widget.currentPage,
                      onNextPressed: widget.onNextPressed,
                      onBackPressed: widget.onBackPressed,
                      onDoItPressed: widget.onDoItPressed,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
