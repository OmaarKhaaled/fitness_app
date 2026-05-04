import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseLevelTabBar extends StatelessWidget {
  final List<LevelModel> levels;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const ExerciseLevelTabBar({
    super.key,
    required this.levels,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Increased height to accommodate the bubble
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: levels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                // Tab Pill
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    levels[index].name,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected
                          ? AppColors.white
                          : AppColors.textSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                ),           
              ],
            ),
          );
        },
      ),
    );
  }
}
