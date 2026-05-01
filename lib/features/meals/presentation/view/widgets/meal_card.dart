import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MealCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final VoidCallback? onTap;

  const MealCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                    Icons.restaurant,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.4),
                      ),
                      child: Text(
                        name ?? '',
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.visible,
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
