import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/features/meals/api/api_client/meals_api_client.dart';
import 'package:fitness_app/features/meals/data/data_sources/meals_data_source.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meals_by_category_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meals_details.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MealsDataSource)
class MealsDataSourceImpl implements MealsDataSource {
  final MealsApiClient _apiClient;

  MealsDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<MealsCategoriesResponse>> getMealsCategories() {
    return apiCall(() async {
      return await _apiClient.getMealsCategories();
    });
  }

  @override
  Future<BaseResponse<MealsByCategoryResponse>> getMealsByCategory(
    String category,
  ) {
    return apiCall(() async {
      return await _apiClient.getMealsByCategory(category);
    });
  }

  @override
  Future<BaseResponse<MealsDetails>> getMealDetails(String mealId) {
    return apiCall(() async {
      return await _apiClient.getMealDetails(mealId);
    });
  }
}
