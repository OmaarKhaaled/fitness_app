import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_state.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/exercise_item_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget buildExerciseList(ExerciseState state) {
  if (state.isExercisesLoading) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, __) => const Skeletonizer(
          enabled: true,
          child: ExerciseItemCard(
            exercise: ExerciseModel(id: '1', name: ''),
          ),
        ),
        childCount: 5,
      ),
    );
  }

  if (state.exercisesError != null) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
            const SizedBox(height: 12),
            Text(
              state.exercisesError!,
              style: GoogleFonts.outfit(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  if (state.exercises.isEmpty && !state.isLevelsLoading) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.inbox_outlined,
              color: AppColors.textSecondary,
              size: 56,
            ),
            const SizedBox(height: 12),
            Text(
              'No exercises found for this level.',
              style: GoogleFonts.outfit(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) => ExerciseItemCard(exercise: state.exercises[index]),
      childCount: state.exercises.length,
    ),
  );
}
