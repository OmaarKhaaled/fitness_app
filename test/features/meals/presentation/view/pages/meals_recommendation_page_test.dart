import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view/pages/meals_recommendation_page.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_cubit.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view_model/meals_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMealsCubit mockMealsCubit;

  setUp(() {
    mockMealsCubit = MockMealsCubit();

    if (getIt.isRegistered<MealsCubit>()) {
      getIt.unregister<MealsCubit>();
    }
    getIt.registerSingleton<MealsCubit>(mockMealsCubit);

    when(mockMealsCubit.uiIntents).thenAnswer((_) => const Stream.empty());
    when(mockMealsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockMealsCubit.state).thenReturn(const MealsStates());
    when(mockMealsCubit.close()).thenAnswer((_) async {});
  });

  tearDown(() {
    if (getIt.isRegistered<MealsCubit>()) {
      getIt.unregister<MealsCubit>();
    }
  });

  Widget buildTestableWidget() {
    return MaterialApp(
      home: BlocProvider<MealsCubit>.value(
        value: mockMealsCubit,
        child: const MealsRecommendationPage(),
      ),
    );
  }

  testWidgets(
    'MealsRecommendationPage should render properly in initial state',
    (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(MealsRecommendationPage), findsOneWidget);
    },
  );
}
