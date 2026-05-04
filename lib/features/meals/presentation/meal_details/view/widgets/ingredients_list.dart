import 'package:fitness_app/features/meals/data/models/meals_details/meal.dart';
import 'package:flutter/material.dart';

class IngredientsList extends StatelessWidget {
  final Meal meal;
  const IngredientsList({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final ingredients = _getIngredients();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = ingredients[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 1),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['name']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  item['measure']!,
                  style: const TextStyle(
                    color: Color(0xFFFF6B00),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
        childCount: ingredients.length,
      ),
    );
  }

  List<Map<String, String>> _getIngredients() {
    final List<Map<String, String>> ingredients = [];
    
    // TheMealDB provides up to 20 ingredients
    final mealMap = meal.toMap();
    
    for (int i = 1; i <= 20; i++) {
      final ingredient = mealMap['strIngredient$i'];
      final measure = mealMap['strMeasure$i'];
      
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add({
          'name': ingredient.toString(),
          'measure': (measure != null && measure.toString().trim().isNotEmpty) 
              ? measure.toString() 
              : '',
        });
      }
    }
    
    return ingredients;
  }
}
