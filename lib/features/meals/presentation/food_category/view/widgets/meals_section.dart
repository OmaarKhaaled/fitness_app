import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view/widgets/meal_card.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view/widgets/meal_category_chips.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view/widgets/meal_skeletons.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_cubit.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_intents.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsSection extends StatefulWidget {
  final VoidCallback onSeeAllTapped;

  const MealsSection({super.key, required this.onSeeAllTapped});

  @override
  State<MealsSection> createState() => _MealsSectionState();
}

class _MealsSectionState extends State<MealsSection> {
  late MealsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<MealsCubit>();
    _cubit.doIntent(const LoadInitialMealsDataIntent());
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider<MealsCubit>.value(
      value: _cubit,
      child: BlocListener<MealsCubit, MealsStates>(
        listenWhen: (prev, curr) =>
            curr.errorMessage != null && prev.errorMessage != curr.errorMessage,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      AppTextConstants.mealsRecommendationForYou,
                      style: textTheme.titleLarge!.copyWith(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onSeeAllTapped,
                    child: Text(
                      AppTextConstants.mealsSeeAll,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<MealsCubit, MealsStates>(
              builder: (context, state) {
                if (state.isCategoriesLoading ||
                    (state.categories.isEmpty && state.isMealsLoading)) {
                  return const UpcomingMealSkeleton();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.categories.isNotEmpty)
                      MealCategoryChips(
                        categories: state.categories,
                        selectedCategory: state.selectedCategory,
                        onSelected: (cat) {
                          _cubit.doIntent(
                            SelectMealCategoryIntent(
                              category: cat.strCategory!,
                            ),
                          );
                        },
                      ),
                    const SizedBox(height: 16),
                    if (state.isMealsLoading)
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
                              child: MealCardSkeleton(),
                            ),
                          ),
                        ),
                      )
                    else if (state.meals.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Text(
                              AppTextConstants.noMealsFound,
                              style: textTheme.titleLarge,
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
                          itemCount: state.meals.length,
                          itemBuilder: (context, index) {
                            final meal = state.meals[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: SizedBox(
                                width: 130,
                                child: MealCard(
                                  imageUrl: meal.strMealThumb,
                                  name: meal.strMeal,
                                  mealId: meal.idMeal,
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
      ),
    );
  }
}
