part of 'meal_detail_cubit.dart';

class MealDetailState {
  final bool isLoading;
  final String? errorMessage;
  final MealsDetails? mealDetails;

  MealDetailState({
    this.isLoading = false,
    this.errorMessage,
    this.mealDetails,
  });

  MealDetailState copyWith({
    bool? isLoading,
    String? errorMessage,
    MealsDetails? mealDetails,
  }) {
    return MealDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      mealDetails: mealDetails ?? this.mealDetails,
    );
  }
}
