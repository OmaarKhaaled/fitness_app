import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meal.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/category.dart';

class MealsStates extends BaseState<void> {
  final List<Category> categories;
  final bool isCategoriesLoading;

  final String? selectedCategory;

  final List<Meal> meals;
  final bool isMealsLoading;

  const MealsStates({
    super.isLoading = false,
    super.errorMessage,
    this.categories = const [],
    this.isCategoriesLoading = false,
    this.selectedCategory,
    this.meals = const [],
    this.isMealsLoading = false,
  });

  @override
  MealsStates copyWith({
    void data,
    bool? isLoading,
    String? errorMessage,
    List<Category>? categories,
    bool? isCategoriesLoading,
    String? selectedCategory,
    List<Meal>? meals,
    bool? isMealsLoading,
  }) {
    return MealsStates(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      meals: meals ?? this.meals,
      isMealsLoading: isMealsLoading ?? this.isMealsLoading,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    categories,
    isCategoriesLoading,
    selectedCategory,
    meals,
    isMealsLoading,
  ];
}
