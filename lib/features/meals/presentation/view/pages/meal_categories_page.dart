import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/features/meals/presentation/view/pages/meals_recommendation_page.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_cubit.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealCategoriesPage extends StatelessWidget {
  const MealCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MealsCubit>()..doIntent(const LoadInitialMealsDataIntent()),
      child: const MealsRecommendationPage(),
    );
  }
}
