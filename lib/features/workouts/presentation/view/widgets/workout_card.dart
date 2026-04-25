import 'dart:ui'; // Required for ImageFilter
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/muscle.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.onTap,
  });

  factory WorkoutCard.fromMuscle(Muscle muscle, {VoidCallback? onTap}) {
    return WorkoutCard(imageUrl: muscle.image, name: muscle.name, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.08),
            width: 0.8,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor,
                  child: Container(color: AppColors.white),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.transparent,
                  child: Icon(
                    Icons.fitness_center,
                    color: AppColors.white.withValues(alpha: 0.2),
                    size: 32,
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.4),
                      ),
                      child: Text(
                        name ?? '',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
