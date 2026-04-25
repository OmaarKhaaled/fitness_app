import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/muscle_group_chips.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/workout_card.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/workout_skeletons.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/workout_states.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/wourkout_cubit.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/wourkout_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsSection extends StatefulWidget {
  final VoidCallback onSeeAllTapped;

  const WorkoutsSection({super.key, required this.onSeeAllTapped});

  @override
  State<WorkoutsSection> createState() => _WorkoutsSectionState();
}

class _WorkoutsSectionState extends State<WorkoutsSection> {
  late WorkoutCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<WorkoutCubit>();
    _cubit.doIntent(LoadInitialDataIntent());
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider<WorkoutCubit>.value(
      value: _cubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Workouts',
                  style: textTheme.titleLarge!.copyWith(fontSize: 20),
                ),
                GestureDetector(
                  onTap: widget.onSeeAllTapped,
                  child: Text(
                    'See All',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          BlocBuilder<WorkoutCubit, WorkoutStates>(
            builder: (context, state) {
              if (state.isMuscleGroupsLoading) {
                return const UpcomingWorkoutSkeleton();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.muscleGroups.isNotEmpty)
                    MuscleGroupChips(
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
                  const SizedBox(height: 16),

                  if (state.isMusclesLoading)
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 4,
                        itemBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: SizedBox(
                            width: 130,
                            child: WorkoutCardSkeleton(),
                          ),
                        ),
                      ),
                    )
                  else if (state.muscles.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            'No workouts found',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.muscles.length,
                        itemBuilder: (context, index) {
                          final muscle = state.muscles[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              width: 130,
                              child: WorkoutCard(
                                imageUrl: muscle.image,
                                name: muscle.name,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
