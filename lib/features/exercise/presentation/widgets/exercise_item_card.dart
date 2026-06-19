import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseItemCard extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback? onPlayTap;

  const ExerciseItemCard({super.key, required this.exercise, this.onPlayTap});
  @override
  Widget build(BuildContext context) {
    final String? videoId = YoutubePlayer.convertUrlToId(
      exercise.inDepthYoutubeExplanationLink ??
          exercise.shortYoutubeDemonstrationLink ??
          '',
    );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          /// Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: 80,
              height: 80,
              child: exercise.thumbnailUrl != null
                  ? CachedNetworkImage(
                      imageUrl: exercise.thumbnailUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildPlaceholder(),
                      errorWidget: (context, url, error) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),

          const SizedBox(width: 16),

          /// Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  exercise.targetMuscleGroup ?? 'General Exercise',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '${exercise.difficultyLevel ?? 'Any'} • '
                  '${exercise.primaryEquipment ?? 'No Equipment'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),

          if (videoId != null)
            IconButton(
              onPressed: () {
                final controller = YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                    showLiveFullscreenButton: true,
                    enableCaption: true,
                  ),
                );
                showDialog(
                  context: context,
                  builder: (context) => YoutubePlayer(
                    controller: controller,
                    progressIndicatorColor: AppColors.primary,
                    progressColors: const ProgressBarColors(
                      playedColor: AppColors.primary,
                      bufferedColor: AppColors.primary,
                      handleColor: AppColors.primary,
                      backgroundColor: AppColors.primary,
                    ),
                    aspectRatio: 9 / 16,
                    thumbnail: CachedNetworkImage(
                      imageUrl: exercise.thumbnailUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildPlaceholder(),
                      errorWidget: (context, url, error) => _buildPlaceholder(),
                    ),
                    bottomActions: [
                      const RemainingDuration(),
                      IconButton(
                        onPressed: () {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          } else {
                            controller.play();
                          }
                        },
                        icon: Icon(
                          controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                      ),
                      ProgressBar(
                        controller: controller,
                        isExpanded: true,
                        colors: const ProgressBarColors(
                          playedColor: AppColors.primary,
                          handleColor: AppColors.primary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.fullscreen),
                        onPressed: () {
                          controller.toggleFullScreenMode();
                        },
                      ),
                    ],
                    onReady: () {
                      controller.play();
                    },
                    topActions: [
                      Text(
                        exercise.name,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },

              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF2A2A2A),
      child: const Icon(
        Icons.fitness_center,
        color: AppColors.primary,
        size: 32,
      ),
    );
  }
}
