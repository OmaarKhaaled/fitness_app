import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseItemCard extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback? onPlayTap;

  const ExerciseItemCard({
    super.key,
    required this.exercise,
    this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = [
      exercise.mechanics,
      exercise.primaryEquipment,
    ].where((e) => e != null && e.isNotEmpty).join(' · ');

    final detail = [
      exercise.movementPattern1,
      exercise.bodyRegion,
    ].where((e) => e != null && e.isNotEmpty).join(' · ');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            child: exercise.shortYoutubeDemonstrationLink != null
                ? CachedNetworkImage(
                    imageUrl: exercise.shortYoutubeDemonstrationLink!,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => _buildPlaceholder(),
                    errorWidget: (_, __, ___) => _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
          ),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (detail.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      detail,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Play button
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: onPlayTap,
              child: Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 90,
      height: 90,
      color: const Color(0xFF2A2A2A),
      child: const Icon(
        Icons.fitness_center,
        color: AppColors.primary,
        size: 32,
      ),
    );
  }
}
