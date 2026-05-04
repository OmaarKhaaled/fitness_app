import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatPill extends StatelessWidget {
  final ExerciseModel exercise;
  StatPill({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mediaQuery.size.width * .02,
        vertical: mediaQuery.size.height * .01,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        exercise.name,
        style: GoogleFonts.outfit(
          fontSize: 12,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

ExerciseModel skeletonExercise = const ExerciseModel(
  id: '1',
  name: '',
  difficultyLevel: '',
  targetMuscleGroup: '',
  primeMoverMuscle: '',
  primaryEquipment: '',
  mechanics: '',
  posture: '',
  movementPattern1: '',
  bodyRegion: '',
  forceType: '',
  shortYoutubeDemonstrationLink: '',
  inDepthYoutubeExplanationLink: '',
);
