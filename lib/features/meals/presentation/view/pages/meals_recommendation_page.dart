import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/meals/presentation/view/widgets/meal_card.dart';
import 'package:fitness_app/features/meals/presentation/view/widgets/meal_category_chips.dart';
import 'package:fitness_app/features/meals/presentation/view/widgets/meal_skeletons.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_cubit.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_intents.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsRecommendationPage extends StatefulWidget {
  const MealsRecommendationPage({super.key});

  @override
  State<MealsRecommendationPage> createState() =>
      _MealsRecommendationPageState();
}

class _MealsRecommendationPageState extends State<MealsRecommendationPage> {
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
    return BlocProvider<MealsCubit>.value(
      value: _cubit,
      child: AppScaffold(
        backgroundImage: AppAssets.homeBackGround,
        child: BlocBuilder<MealsCubit, MealsStates>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.transparent,
                  elevation: 0,
                  pinned: true,
                  leading: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    AppTextConstants.foodRecommendation,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  centerTitle: true,
                ),

                // ── Category chips ────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 4),
                    child: state.isCategoriesLoading
                        ? SizedBox(
                            height: 38,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: 6,
                              itemBuilder: (context, index) =>
                                  const MealCategoryChipSkeleton(),
                            ),
                          )
                        : MealCategoryChips(
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
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                if (state.isMealsLoading)
                  const SliverToBoxAdapter(
                    child: MealGridSkeleton(itemCount: 6),
                  )
                else if (state.meals.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Column(
                          children: [
                            Icon(
                              Icons.restaurant,
                              color: AppColors.white.withValues(alpha: 0.3),
                              size: 48,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              AppTextConstants.noMealsFound,
                              style: TextStyle(
                                color: AppColors.white.withValues(alpha: 0.5),
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
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                            childAspectRatio: 0.80,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final meal = state.meals[index];
                        return MealCard(
                          imageUrl: meal.strMealThumb,
                          name: meal.strMeal,
                        );
                      }, childCount: state.meals.length),
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            );
          },
        ),
      ),
    );
  }
}
