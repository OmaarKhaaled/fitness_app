import 'package:fitness_app/features/meals/presentation/view/widgets/meal_category_chips.dart';
import 'package:flutter/material.dart';

class MealDetailPage extends StatelessWidget {
  const MealDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MealCategoryChips(
      categories: const [],
      selectedCategory: '',
      onSelected: (cat) => {},
    );
  }
}
