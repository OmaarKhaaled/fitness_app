import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_intent.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_state.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/exercise_item_card.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/exercise_level_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/exercise/domain/models/muscle_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExerciseScreen extends StatelessWidget {
  final MuscleModel muscle;
  const ExerciseScreen({super.key, required this.muscle});

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildLevelTabs(context, state),
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


  SliverAppBar _buildHeroAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      pinned: true,
      backgroundColor: const Color(0xFF121212),
      leadingWidth: 64,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white,
              size: 14,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              'assets/images/exercise.jpg',
              fit: BoxFit.cover,
            ),
            // Gradient Overlay
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0x80121212),
                    Color(0xFF121212),
                  ],
                  stops: [0.3, 0.7, 1.0],
                ),
              ),
            ),
            // Overlay Content
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${muscle.name} Exercise',
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem Ipsum Dolor Sit Amet Consectetur. Tempus Volutpat Ut Nisi Morbi.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildStatsRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Stats Row ─────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _statPill(label: '30 MIN'),
        const SizedBox(width: 12),
        // Avatar with bubble-like feel
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2),
            color: const Color(0xFF2A2A2A),
          ),
          child: const Icon(Icons.person, color: AppColors.white, size: 24),
        ),
        const SizedBox(width: 12),
        _caloriePill(label: '130 Cal'),
      ],
    );
  }

  Widget _statPill({required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 12,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _caloriePill({required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 12,
          color: AppColors.primary,
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
          (_, __) => const Skeletonizer(
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
