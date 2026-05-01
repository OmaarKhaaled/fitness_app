import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meals_by_category_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meals_details.dart';
import 'package:fitness_app/features/meals/data/repositories/meals_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MealsRepositoryImpl repository;
  late MockMealsDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockMealsDataSource();
    repository = MealsRepositoryImpl(mockDataSource);
  });

  group('MealsRepositoryImpl', () {
    const tCategory = 'Beef';
    const tMealId = '52874';

    test(
      'should return MealsCategoriesResponse when getMealsCategories is called',
      () async {
        // arrange
        const tResponse = MealsCategoriesResponse(categories: []);
        const tBaseResponse = BaseResponse.success(tResponse);
        when(
          mockDataSource.getMealsCategories(),
        ).thenAnswer((_) async => tBaseResponse);

        // act
        final result = await repository.getMealsCategories();

        // assert
        verify(mockDataSource.getMealsCategories()).called(1);
        expect(result, tBaseResponse);
      },
    );

    test(
      'should return MealsByCategoryResponse when getMealsByCategory is called',
      () async {
        // arrange
        const tResponse = MealsByCategoryResponse(meals: []);
        const tBaseResponse = BaseResponse.success(tResponse);
        when(
          mockDataSource.getMealsByCategory(tCategory),
        ).thenAnswer((_) async => tBaseResponse);

        // act
        final result = await repository.getMealsByCategory(tCategory);

        // assert
        verify(mockDataSource.getMealsByCategory(tCategory)).called(1);
        expect(result, tBaseResponse);
      },
    );

    test('should return MealsDetails when getMealDetails is called', () async {
      // arrange
      const tResponse = MealsDetails(meals: []);
      const tBaseResponse = BaseResponse.success(tResponse);
      when(
        mockDataSource.getMealDetails(tMealId),
      ).thenAnswer((_) async => tBaseResponse);

      // act
      final result = await repository.getMealDetails(tMealId);

      // assert
      verify(mockDataSource.getMealDetails(tMealId)).called(1);
      expect(result, tBaseResponse);
    });
  });
}
