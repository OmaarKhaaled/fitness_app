import 'package:fitness_app/features/meals/api/api_client/meals_api_client.dart';
import 'package:fitness_app/features/meals/data/data_sources/meals_data_source.dart';
import 'package:fitness_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:fitness_app/features/meals/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:fitness_app/features/meals/domain/use_cases/get_meals_categories_use_case.dart';
import 'package:fitness_app/features/meals/domain/use_cases/get_meal_details_use_case.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_cubit.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MealsApiClient,
  MealsDataSource,
  MealsRepository,
  GetMealsCategoriesUseCase,
  GetMealsByCategoryUseCase,
  GetMealDetailsUseCase,
  MealsCubit,
])
void main() {}
