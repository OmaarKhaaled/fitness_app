import 'dart:developer';

import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class OnBoardingNavigation extends StatefulWidget {
  const OnBoardingNavigation({
    super.key,
    required this.controller,
    required this.currentPage,
  });
  final PageController controller;
  final int currentPage;

  @override
  State<OnBoardingNavigation> createState() => _OnBoardingNavigationState();
}

class _OnBoardingNavigationState extends State<OnBoardingNavigation> {
  @override
  Widget build(BuildContext context) {
    log(widget.currentPage.toString());
    return AnimatedSwitcher(
      reverseDuration: const Duration(milliseconds: 400),

      duration: const Duration(milliseconds: 400),

      child: (widget.currentPage) == 0
          ? ElevatedButton(
              onPressed: () {
                widget.controller.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(AppTextConstants.onboardingNextButton),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.controller.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(AppTextConstants.onboardingBackButton),
                ),
                (widget.currentPage) != 2
                    ? ElevatedButton(
                        onPressed: () {
                          widget.controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(AppTextConstants.onboardingNextButton),
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        child: Text(AppTextConstants.onboardingDoItButton),
                      ),
              ],
            ),
    );
  }
}
