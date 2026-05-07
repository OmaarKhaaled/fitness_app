import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view/widgets/popular_training_card.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view_model/popular_training_cubit.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view_model/popular_training_intents.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view_model/popular_training_states.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/workout_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PopularTrainingSection extends StatefulWidget {
  const PopularTrainingSection({super.key});

  @override
  State<PopularTrainingSection> createState() => _PopularTrainingSectionState();
}

class _PopularTrainingSectionState extends State<PopularTrainingSection> {
  late PopularTrainingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PopularTrainingCubit>()
      ..doIntent(const LoadPopularTrainingIntent());
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider<PopularTrainingCubit>.value(
      value: _cubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppTextConstants.popularTraining,
              style: textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<PopularTrainingCubit, PopularTrainingStates>(
            builder: (context, state) {
              if (state.isLoading) {
                return SizedBox(
                  height: 260,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 3,
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(right: 14),
                      child: SizedBox(width: 260, child: WorkoutCardSkeleton()),
                    ),
                  ),
                );
              }

              if (state.data?.isEmpty ?? true) {
                return const SizedBox();
              }

              return SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.data!.length,
                  itemBuilder: (context, index) {
                    final item = state.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: PopularTrainingCard(
                        item: item,
                        onTap: () {
                          context.push(
                            AppRoutesConstants.exercisesRoute,
                            extra: ExerciseModel(
                              id: item.muscle.id ?? '',
                              name: item.muscle.name ?? '',
                              targetMuscleGroup: item.muscle.name ?? '',
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
