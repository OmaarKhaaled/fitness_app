import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meal.dart';
import 'package:fitness_app/features/meals/presentation/meal_details/view/widgets/ingredients_list.dart';
import 'package:fitness_app/features/meals/presentation/meal_details/view_model/cubit/meal_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealDetailCubit, MealDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.isLoading) {
          return const AppScaffold(
            backgroundImage: AppAssets.authBackground,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        if (state.errorMessage != null) {
          return AppScaffold(
            backgroundImage: AppAssets.homeBackGround,
            child: Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final mealDetails = state.mealDetails?.meals;
        if (mealDetails == null || mealDetails.isEmpty) {
          return AppScaffold(
            backgroundImage: AppAssets.homeBackGround,
            child: Center(
              child: Text(
                AppTextConstants.noMealsFound,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final meal = mealDetails[0];

        return Scaffold(
          backgroundColor: Colors.black,
          body: CustomScrollView(
            slivers: [
              // Header Image with Back Button
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: Colors.black,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF6B00), // Orange from design
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: meal.strMealThumb ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[900]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      // Gradient Overlay for text readability
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.8),
                            ],
                          ),
                        ),
                      ),
                      // Title and Subtitle
                      Positioned(
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meal.strMeal ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              meal.strInstructions?.split('\n').first ??
                                  'Delicious meal prepared with fresh ingredients.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Nutritional Info Badges
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNutritionBadge('100 K', 'Energy'),
                      _buildNutritionBadge('15 G', 'Protein'),
                      _buildNutritionBadge('58 G', 'Carbs'),
                      _buildNutritionBadge('20 G', 'Fat'),
                    ],
                  ),
                ),
              ),

              // Ingredients Heading
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    'Ingredients',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Ingredients List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: IngredientsList(meal: meal),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNutritionBadge(String value, String label) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        color: Colors.white.withValues(alpha: 0.05),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Color(0xFFFF6B00), fontSize: 10),
          ),
        ],
      ),
    );
  }
}
