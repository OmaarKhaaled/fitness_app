import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMealsCategoriesUseCase {
  final MealsRepository _repository;

  GetMealsCategoriesUseCase(this._repository);

  Future<BaseResponse<MealsCategoriesResponse>> call() {
    return _repository.getMealsCategories();
  }
}
