import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meals_by_category_response.dart';
import 'package:fitness_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMealsByCategoryUseCase {
  final MealsRepository _repository;

  GetMealsByCategoryUseCase(this._repository);

  Future<BaseResponse<MealsByCategoryResponse>> call(String category) {
    return _repository.getMealsByCategory(category);
  }
}
