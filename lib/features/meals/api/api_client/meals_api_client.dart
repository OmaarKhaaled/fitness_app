import 'package:dio/dio.dart';
import 'package:fitness_app/core/constants/api_constants.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meals_by_category_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meals_details.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'meals_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.mealsDbBaseUrl)
abstract class MealsApiClient {
  @factoryMethod
  factory MealsApiClient(Dio dio) = _MealsApiClient;

  @GET(ApiConstants.mealsCategoriesEndpoint)
  Future<MealsCategoriesResponse> getMealsCategories();

  @GET(ApiConstants.getMealsByCategoryEndpoint)
  Future<MealsByCategoryResponse> getMealsByCategory(
    @Query('c') String category,
  );

  @GET(ApiConstants.getMealDetailsEndpoint)
  Future<MealsDetails> getMealDetails(@Query('i') String mealId);
}
