import 'package:fitness_app/config/di/di.dart';
import '../manager/cubit/exercise_cubit.dart';
import '../manager/cubit/exercise_intent.dart';
import 'exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisePage extends StatelessWidget {
  final String muscleId;
  const ExercisePage({super.key, 
  required this.muscleId
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExerciseCubit>()
        ..doIntent(LoadLevels(muscleId: muscleId)),
      child: ExerciseScreen(
        muscleId: muscleId
        ),
    );
  }
}
