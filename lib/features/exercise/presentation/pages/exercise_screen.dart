import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/routing/route_names.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:fitness_app/features/exercise/presentation/manager/cubit/exercise_state.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/exercise_list.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/level_tabs.dart';
import 'package:fitness_app/features/exercise/presentation/widgets/stat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseScreen extends StatelessWidget {
  final ExerciseModel exercise;
  const ExerciseScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AppScaffold(
      backgroundImage: AppAssets.homeBackGround,
      hasGradient: true,
      child: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              buildHeroAppBar(context),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: LevelTabs(),
                ),
              ),
              buildExerciseList(state),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          );
        },
      ),
    );
  }

  SliverAppBar buildHeroAppBar(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SliverAppBar(
      floating: true,
      expandedHeight: mediaQuery.size.height * .5,
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
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.white,
                size: 14,
              ),
              onPressed: () => context.go(AppRoutesConstants.homeRoute),
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
              opacity: const AlwaysStoppedAnimation(0.8),
            ),
            // Gradient Overlay
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.black,
                    AppColors.black,
                  ],
                  stops: [0.3, 0.6, 1.0],
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
                    '${exercise.name} Exercise',
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
                  StatRow(exercise: exercise),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
