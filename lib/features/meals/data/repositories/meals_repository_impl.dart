import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/meals/data/data_sources/meals_data_source.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meals_by_category_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meals_details.dart';
import 'package:fitness_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MealsRepository)
class MealsRepositoryImpl implements MealsRepository {
  final MealsDataSource _dataSource;

  MealsRepositoryImpl(this._dataSource);

  @override
  Future<BaseResponse<MealsCategoriesResponse>> getMealsCategories() {
    return _dataSource.getMealsCategories();
  }

  @override
  Future<BaseResponse<MealsByCategoryResponse>> getMealsByCategory(
    String category,
  ) {
    return _dataSource.getMealsByCategory(category);
  }

  @override
  Future<BaseResponse<MealsDetails>> getMealDetails(String mealId) {
    return _dataSource.getMealDetails(mealId);
  }
}
