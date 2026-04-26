import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meals_by_category_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meals_details.dart';

abstract class MealsDataSource {
  Future<BaseResponse<MealsCategoriesResponse>> getMealsCategories();
  Future<BaseResponse<MealsByCategoryResponse>> getMealsByCategory(
    String category,
  );
  Future<BaseResponse<MealsDetails>> getMealDetails(String mealId);
}
