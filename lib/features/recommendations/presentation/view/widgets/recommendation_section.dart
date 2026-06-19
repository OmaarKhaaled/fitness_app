import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/workout_card.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/workout_skeletons.dart';
import 'package:fitness_app/features/recommendations/presentation/view_model/recommendation_cubit.dart';
import 'package:fitness_app/features/recommendations/presentation/view_model/recommendation_intents.dart';
import 'package:fitness_app/features/recommendations/presentation/view_model/recommendation_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecommendationSection extends StatefulWidget {
  const RecommendationSection({super.key});

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection> {
  late RecommendationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<RecommendationCubit>()
      ..doIntent(const LoadRecommendationsIntent());
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider<RecommendationCubit>.value(
      value: _cubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppTextConstants.recommendationToDay,
                    style: textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<RecommendationCubit, RecommendationStates>(
            builder: (context, state) {
              if (state.isLoading) {
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 3,
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: SizedBox(width: 130, child: WorkoutCardSkeleton()),
                    ),
                  ),
                );
              }

              if (state.data?.isEmpty ?? true) {
                return const SizedBox();
              }

              return SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.data?.length,
                  itemBuilder: (context, index) {
                    final item = state.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 130,
                        child: WorkoutCard(
                          imageUrl: item.image,
                          name: item.name,
                          exerciseModel: ExerciseModel(
                            id: item.id ?? '',
                            name: item.name ?? '',
                            targetMuscleGroup: item.name ?? '',
                          ),
                          onTap: () {
                            context.push(
                              AppRoutesConstants.exercisesRoute,
                              extra: ExerciseModel(
                                id: item.id ?? '',
                                name: item.name ?? '',
                                targetMuscleGroup: item.name ?? '',
                              ),
                            );
                          },
                        ),
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
