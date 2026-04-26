import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/muscle_group_chips.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/workout_card.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/workout_skeletons.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/workout_states.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/wourkout_cubit.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/wourkout_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsTab extends StatefulWidget {
  final ScrollController scrollController;
  const WorkoutsTab({super.key, required this.scrollController});

  @override
  State<WorkoutsTab> createState() => _WorkoutsTabState();
}

class _WorkoutsTabState extends State<WorkoutsTab> {
  late WorkoutCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<WorkoutCubit>();
    _cubit.doIntent(const LoadInitialDataIntent());
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutCubit>.value(
      value: _cubit,
      child: BlocBuilder<WorkoutCubit, WorkoutStates>(
        builder: (context, state) {
          return CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
                  child: Center(
                    child: Text(
                      AppTextConstants.workoutsIcon,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: state.isMuscleGroupsLoading
                    ? SizedBox(
                        height: 38,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: 6,
                          itemBuilder: (context, index) =>
                              const WorkoutChipSkeleton(),
                        ),
                      )
                    : MuscleGroupChips(
                        muscleGroups: state.muscleGroups,
                        selectedMuscleGroupId: state.selectedMuscleGroupId,
                        onSelected: (group) {
                          _cubit.doIntent(
                            SelectMuscleGroupIntent(
                              muscleGroupId: group.id,
                              muscleGroupName: group.name!,
                            ),
                          );
                        },
                      ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              if (state.isMusclesLoading)
                const SliverToBoxAdapter(
                  child: WorkoutGridSkeleton(itemCount: 6),
                )
              else if (state.muscles.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Column(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            color: Colors.white.withValues(alpha: 0.3),
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppTextConstants.noWorkoutsFound,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.80,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final muscle = state.muscles[index];
                      return WorkoutCard(
                        imageUrl: muscle.image,
                        name: muscle.name,
                      );
                    }, childCount: state.muscles.length),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          );
        },
      ),
    );
  }
}
