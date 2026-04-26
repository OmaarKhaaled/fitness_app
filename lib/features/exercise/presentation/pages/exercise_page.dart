import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import '../manager/cubit/exercise_cubit.dart';
import '../manager/cubit/exercise_intent.dart';
import 'exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisePage extends StatelessWidget {
  final ExerciseModel exercise;
  const ExercisePage({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ExerciseCubit>()..doIntent(LoadLevels(exercise: exercise)),
      child: ExerciseScreen(exercise: exercise),
    );
  }
}
