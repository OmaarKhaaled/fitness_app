import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meal.dart';
import 'package:fitness_app/features/meals/presentation/meal_details/view/widgets/ingredients_list.dart';
import 'package:fitness_app/features/meals/presentation/meal_details/view_model/cubit/meal_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/meals/presentation/meal_details/view/widgets/meal_details_header.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return BlocBuilder<MealDetailCubit, MealDetailState>(
      buildWhen: (previous, current) {
        return current.isLoading != previous.isLoading ||
            current.mealDetails != previous.mealDetails ||
            current.errorMessage != previous.errorMessage;
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const AppScaffold(
            backgroundImage: AppAssets.homeBackGround,

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

        return AppScaffold(
          backgroundImage: AppAssets.homeBackGround,
          child: CustomScrollView(
            slivers: [
              MealDetailsHeader(meal: meal),

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

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Text(
                    AppTextConstants.ingredients,
                    style: const TextStyle(color: AppColors.white),
                  ),
                ),
              ),

              // Ingredients List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: IngredientsList(meal: meal),
              ),

              // Instructions Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 30, 16, 10),
                  child: Text(
                    AppTextConstants.instructions,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              InstructionContent(meal: meal),

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
        border: Border.all(color: AppColors.white.withValues(alpha: 0.2)),
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
            softWrap: true,
          ),
          Text(
            label,
            style: const TextStyle(color: AppColors.primary, fontSize: 10),
          ),
        ],
      ),
    );
  }
}


class InstructionContent extends StatelessWidget {
  const InstructionContent({super.key, required this.meal});

  final Meal meal;

  String _getFormattedInstructions(String? instructions) {
    if (instructions == null || instructions.isEmpty) return '';

    // Split by period followed by space, or by newlines
    final steps = instructions
        .split(RegExp(r'\.\s*|\n+|\.\n+'))
        .where((s) => s.trim().isNotEmpty)
        .toList();

    if (steps.isEmpty) return instructions;

    // Map each step to a numbered list item
    return steps
        .asMap()
        .entries
        .map((entry) => '${entry.key + 1}. ${entry.value.trim()}.')
        .join('\n\n'); // Add extra spacing between steps for readability
  }

  @override
  Widget build(BuildContext context) {
    final formattedInstructions = _getFormattedInstructions(meal.strInstructions);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            formattedInstructions,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ),
      ),
    );
  }
}
