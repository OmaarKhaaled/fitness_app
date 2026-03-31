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
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 31,
              ),
              child: Column(
                children: [
                  SlideTitle(currentPage: widget.currentPage),
                  SlideDescription(currentPage: widget.currentPage),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomIndicator(currentPage: widget.currentPage),
                        const SizedBox(height: 24),
                        OnBoardingNavigation(
                          currentPage: widget.currentPage,
                          onNextPressed: widget.onNextPressed,
                          onBackPressed: widget.onBackPressed,
                          onDoItPressed: widget.onDoItPressed,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
