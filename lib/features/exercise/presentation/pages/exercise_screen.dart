import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_intent.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_state.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/exercise_item_card.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/exercise_level_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExerciseScreen extends StatelessWidget {
  final String muscleId;
  const ExerciseScreen({super.key, required this.muscleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              _buildHeroAppBar(context),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(),
                    const SizedBox(height: 12),
                    _buildStatsRow(),
                    const SizedBox(height: 20),
                    _buildLevelTabs(context, state),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              _buildExerciseList(state),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          );
        },
      ),
    );
  }

  // ── Hero SliverAppBar ─────────────────────────────────────────────────────

  SliverAppBar _buildHeroAppBar(BuildContext context) {

    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: const Color(0xFF121212),
      leading: GestureDetector(
        onTap: () => Navigator.of(context).maybePop(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
            size: 16,
          ),
        ),
      ),
      title: Text(
        'Exercise',
        style: GoogleFonts.outfit(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient placeholder matching the design's dark hero
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2A2A2A),
                    Color(0xFF1A1A1A),
                    Color(0xFF121212),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.fitness_center,
                  size: 72,
                  color: AppColors.primary,
                ),
              ),
            ),
            // Bottom fade
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xFF121212)],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Title ─────────────────────────────────────────────────────────────────

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$muscleId Exercise',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Select a difficulty level and start training '
            'with exercises tailored to your prime mover muscle.',
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats Row ─────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _statPill(icon: Icons.timer_outlined, label: '30 MIN'),
          const SizedBox(width: 12),
          // Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF2A2A2A),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: const Icon(Icons.person, color: AppColors.white, size: 20),
          ),
          const Spacer(),
          _caloriePill(label: '130 Cal'),
        ],
      ),
    );
  }

  Widget _statPill({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _caloriePill({required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 12,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ── Level Tabs ────────────────────────────────────────────────────────────

  Widget _buildLevelTabs(BuildContext context, ExerciseState state) {
    if (state.isLevelsLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(
            3,
            (_) => Container(
              margin: const EdgeInsets.only(right: 8),
              width: 90,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      );
    }

    if (state.levelsError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Failed to load levels: ${state.levelsError}',
          style: GoogleFonts.outfit(color: Colors.redAccent, fontSize: 13),
        ),
      );
    }

    if (state.levels.isEmpty) return const SizedBox.shrink();

    return ExerciseLevelTabBar(
      levels: state.levels,
      selectedIndex: state.selectedLevelIndex,
      onTap: (index) =>
          context.read<ExerciseCubit>().doIntent(SelectLevel(index)),
    );
  }

  // ── Exercise List ─────────────────────────────────────────────────────────

  Widget _buildExerciseList(ExerciseState state) {
    if (state.isExercisesLoading) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, __) => Skeletonizer(
            enabled: true,
            child: ExerciseItemCard(exercise: _skeletonExercise),
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
              const Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 48,
              ),
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
}

// Skeleton placeholder exercise for loading state
const _skeletonExercise = ExerciseModel(
  id: 'skeleton',
  name: 'Bench Press Exercise Name',
  difficultyLevel: 'Intermediate',
  targetMuscleGroup: 'Chest',
  primaryEquipment: 'Barbell',
  mechanics: 'Compound',
  movementPattern1: 'Push',
  bodyRegion: 'Upper Body',
);
