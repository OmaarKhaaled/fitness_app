import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/workouts/data/models/workout_response/muscles_group.dart';
import 'package:flutter/material.dart';

class MuscleGroupChips extends StatelessWidget {
  final List<MusclesGroup> muscleGroups;
  final String? selectedMuscleGroupId;
  final ValueChanged<MusclesGroup> onSelected;

  const MuscleGroupChips({
    super.key,
    required this.muscleGroups,
    required this.selectedMuscleGroupId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: muscleGroups.length,
        separatorBuilder: (_, __) => const SizedBox(width: 2),
        itemBuilder: (context, index) {
          final group = muscleGroups[index];
          final isSelected = group.id == selectedMuscleGroupId;

          return GestureDetector(
            onTap: () => onSelected(group),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.transparent,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  group.name ?? '',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: isSelected ? 16 : 15,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
