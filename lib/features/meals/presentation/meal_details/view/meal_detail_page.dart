import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/features/meals/presentation/meal_details/view/widgets/meal_detail_screen.dart';
import 'package:fitness_app/features/meals/presentation/meal_details/view_model/cubit/meal_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealDetailPage extends StatelessWidget {
  final String mealId;
  const MealDetailPage({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    debugPrint('MealDetailPage: Received mealId = $mealId');
    return BlocProvider(
      create: (context) => getIt<MealDetailCubit>()..getMealDetails(mealId),
      child: const MealDetailScreen(),
    );
  }
}
