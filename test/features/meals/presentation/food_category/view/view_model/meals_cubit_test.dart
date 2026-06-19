import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meal.dart';
import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meals_by_category_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/category.dart';
import 'package:fitness_app/features/meals/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_cubit.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_intents.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_states.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_ui_intents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MealsCubit cubit;
  late MockGetMealsCategoriesUseCase mockGetMealsCategoriesUseCase;
  late MockGetMealsByCategoryUseCase mockGetMealsByCategoryUseCase;

  setUp(() {
    mockGetMealsCategoriesUseCase = MockGetMealsCategoriesUseCase();
    mockGetMealsByCategoryUseCase = MockGetMealsByCategoryUseCase();
    cubit = MealsCubit(
      getMealsCategoriesUseCase: mockGetMealsCategoriesUseCase,
      getMealsByCategoryUseCase: mockGetMealsByCategoryUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('MealsCubit', () {
    const tCategory = Category(idCategory: '1', strCategory: 'Beef');
    const tMeal = Meal(idMeal: '52874', strMeal: 'Beef and Mustard Pie');
    const tException = AppException('Error');

    test('initial state should be empty', () {
      expect(cubit.state, const MealsStates());
    });

    group('LoadInitialMealsDataIntent', () {
      test(
        'should load categories and then load meals for the first category',
        () async {
          // arrange
          const tCategoriesResponse = MealsCategoriesResponse(
            categories: [tCategory],
          );
          const tMealsResponse = MealsByCategoryResponse(meals: [tMeal]);

          when(mockGetMealsCategoriesUseCase()).thenAnswer(
            (_) async => const BaseResponse.success(tCategoriesResponse),
          );
          when(
            mockGetMealsByCategoryUseCase(tCategory.strCategory),
          ).thenAnswer((_) async => const BaseResponse.success(tMealsResponse));

          // act
          cubit.doIntent(const LoadInitialMealsDataIntent());

          // assert
          await Future.delayed(Duration.zero);

          expect(cubit.state.isCategoriesLoading, false);
          expect(cubit.state.categories, [tCategory]);
          expect(cubit.state.selectedCategory, tCategory.strCategory);

          await Future.delayed(Duration.zero);
          expect(cubit.state.isMealsLoading, false);
          expect(cubit.state.meals, [tMeal]);

          verify(mockGetMealsCategoriesUseCase()).called(1);
          verify(
            mockGetMealsByCategoryUseCase(tCategory.strCategory),
          ).called(1);
        },
      );

      test('should emit error UI intent when getCategories fails', () async {
        // arrange
        when(
          mockGetMealsCategoriesUseCase(),
        ).thenAnswer((_) async => const BaseResponse.failure(tException));

        cubit.uiIntents.listen(
          expectAsync1((intent) {
            expect(intent, isA<ShowErrorMealsIntent>());
            expect((intent as ShowErrorMealsIntent).error, 'Error');
          }),
        );

        // act
        cubit.doIntent(const LoadInitialMealsDataIntent());

        // assert
        await Future.delayed(Duration.zero);
        expect(cubit.state.isCategoriesLoading, false);
        expect(cubit.state.isMealsLoading, false);
      });
    });

    group('SelectMealCategoryIntent', () {
      test('should load meals for the selected category', () async {
        // arrange
        const tMealsResponse = MealsByCategoryResponse(meals: [tMeal]);
        when(
          mockGetMealsByCategoryUseCase('Chicken'),
        ).thenAnswer((_) async => const BaseResponse.success(tMealsResponse));

        // act
        cubit.doIntent(const SelectMealCategoryIntent(category: 'Chicken'));

        // assert
        await Future.delayed(Duration.zero);

        expect(cubit.state.selectedCategory, 'Chicken');
        expect(cubit.state.isMealsLoading, false);
        expect(cubit.state.meals, [tMeal]);

        verify(mockGetMealsByCategoryUseCase('Chicken')).called(1);
      });
    });

    group('RefreshMealsIntent', () {
      test('should call _loadInitialData', () async {
        // arrange
        const tCategoriesResponse = MealsCategoriesResponse(
          categories: [tCategory],
        );
        const tMealsResponse = MealsByCategoryResponse(meals: [tMeal]);

        when(mockGetMealsCategoriesUseCase()).thenAnswer(
          (_) async => const BaseResponse.success(tCategoriesResponse),
        );
        when(
          mockGetMealsByCategoryUseCase(tCategory.strCategory),
        ).thenAnswer((_) async => const BaseResponse.success(tMealsResponse));

        // act
        cubit.doIntent(const RefreshMealsIntent());

        // assert
        await Future.delayed(Duration.zero);

        expect(cubit.state.isCategoriesLoading, false);
        expect(cubit.state.categories, [tCategory]);

        await Future.delayed(Duration.zero);
        expect(cubit.state.isMealsLoading, false);
        expect(cubit.state.meals, [tMeal]);

        verify(mockGetMealsCategoriesUseCase()).called(1);
        verify(mockGetMealsByCategoryUseCase(tCategory.strCategory)).called(1);
      });
    });
  });
}
