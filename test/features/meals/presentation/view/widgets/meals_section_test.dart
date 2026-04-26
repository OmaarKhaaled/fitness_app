import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/features/meals/presentation/view/widgets/meals_section.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_cubit.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_states.dart';
import 'package:flutter/material.dart';
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
      home: Scaffold(body: MealsSection(onSeeAllTapped: () {})),
    );
  }

  testWidgets('MealsSection should render properly in initial state', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.byType(MealsSection), findsOneWidget);
  });
}
