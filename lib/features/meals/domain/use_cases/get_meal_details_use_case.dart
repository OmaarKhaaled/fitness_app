import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meals_details.dart';
import 'package:fitness_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMealDetailsUseCase {
  final MealsRepository _repository;

  GetMealDetailsUseCase(this._repository);

  Future<BaseResponse<MealsDetails>> call(String mealId) {
    return _repository.getMealDetails(mealId);
  }
}
