import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/calorie_pill.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/stat_pill.dart';
import 'package:flutter/material.dart';

class StatRow extends StatelessWidget {
  final ExerciseModel exercise;
  const StatRow({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatPill(exercise: exercise),
        const SizedBox(width: 12),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2),
            color: AppColors.white.withValues(alpha: .2),
          ),
          child: const Icon(Icons.person, color: AppColors.white, size: 24),
        ),
        const SizedBox(width: 12),
        const CaloriePill(label: '130 Cal'),
      ],
    );
  }
}
