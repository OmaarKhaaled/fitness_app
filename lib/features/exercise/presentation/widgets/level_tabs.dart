import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_intent.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_state.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/exercise_level_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class _LevelTabs extends StatelessWidget {
  const _LevelTabs({
    required this.context,
    required this.state,
  });

  final BuildContext context;
  final ExerciseState state;

  @override
  Widget build(BuildContext context) {
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
}