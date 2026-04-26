import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/meals/api/data_sources/meals_data_source_impl.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meals_by_category_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meals_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MealsDataSourceImpl dataSource;
  late MockMealsApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockMealsApiClient();
    dataSource = MealsDataSourceImpl(mockApiClient);
  });

  group('MealsDataSourceImpl', () {
    const tCategory = 'Beef';
    const tMealId = '52874';

    test(
      'should return MealsCategoriesResponse when getMealsCategories is called successfully',
      () async {
        // arrange
        const tResponse = MealsCategoriesResponse(categories: []);
        when(
          mockApiClient.getMealsCategories(),
        ).thenAnswer((_) async => tResponse);

        // act
        final result = await dataSource.getMealsCategories();

        // assert
        verify(mockApiClient.getMealsCategories()).called(1);
        expect(result, isA<BaseResponse<MealsCategoriesResponse>>());
        result.whenOrNull(success: (data) => expect(data, tResponse));
      },
    );

    test(
      'should return MealsByCategoryResponse when getMealsByCategory is called successfully',
      () async {
        // arrange
        const tResponse = MealsByCategoryResponse(meals: []);
        when(
          mockApiClient.getMealsByCategory(tCategory),
        ).thenAnswer((_) async => tResponse);

        // act
        final result = await dataSource.getMealsByCategory(tCategory);

        // assert
        verify(mockApiClient.getMealsByCategory(tCategory)).called(1);
        expect(result, isA<BaseResponse<MealsByCategoryResponse>>());
        result.whenOrNull(success: (data) => expect(data, tResponse));
      },
    );

    test(
      'should return MealsDetails when getMealDetails is called successfully',
      () async {
        // arrange
        const tResponse = MealsDetails(meals: []);
        when(
          mockApiClient.getMealDetails(tMealId),
        ).thenAnswer((_) async => tResponse);

        // act
        final result = await dataSource.getMealDetails(tMealId);

        // assert
        verify(mockApiClient.getMealDetails(tMealId)).called(1);
        expect(result, isA<BaseResponse<MealsDetails>>());
        result.whenOrNull(success: (data) => expect(data, tResponse));
      },
    );
  });
}
