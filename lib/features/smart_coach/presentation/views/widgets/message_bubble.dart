import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.smartCoachBubbleGradientColor,
                  AppColors.smartCoachBubbleGradientColor2,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Text(
              message,
              style: textTheme.titleLarge?.copyWith(height: 1.35),
            ),
          ),
        ),
        const SizedBox(width: 14),
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(AppAssets.modelImage),
        ),
      ],
    );
  }
}
