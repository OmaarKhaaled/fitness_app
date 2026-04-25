import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutCardSkeleton extends StatelessWidget {
  const WorkoutCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      period: const Duration(milliseconds: 1500),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
      ),
    );
  }
}

class WorkoutChipSkeleton extends StatelessWidget {
  const WorkoutChipSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      period: const Duration(milliseconds: 1500),
      child: Container(
        height: 38,
        width: 80,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
      ),
    );
  }
}

class WorkoutGridSkeleton extends StatelessWidget {
  final int itemCount;
  final double childAspectRatio;

  const WorkoutGridSkeleton({
    super.key,
    this.itemCount = 6,
    this.childAspectRatio = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const WorkoutCardSkeleton(),
    );
  }
}

class UpcomingWorkoutSkeleton extends StatelessWidget {
  const UpcomingWorkoutSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) => const WorkoutChipSkeleton(),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 4,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.only(right: 12),
              child: SizedBox(width: 130, child: WorkoutCardSkeleton()),
            ),
          ),
        ),
      ],
    );
  }
}
