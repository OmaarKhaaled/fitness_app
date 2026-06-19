import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view/pages/change_password_view.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view/screens/forget_password_screen.dart';
import 'package:fitness_app/features/exercise/presentation/pages/exercise_page.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view/pages/meal_categories_page.dart';
import 'package:fitness_app/features/meals/presentation/meal_details/view/meal_detail_page.dart';
import 'package:fitness_app/features/workouts/data/models/wourkout_group_response/muscle.dart';
import 'package:fitness_app/features/home/views/screens/home_screen.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_additional_info_screen.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_screen.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/pages/chat_page.dart';
import 'package:flutter/material.dart';
import '../../features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:fitness_app/features/auth/login/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.onboardingRoute,
    routes: [
      GoRoute(
        name: AppRoutesConstants.onboardingRoute,
        path: AppRoutesConstants.onboardingRoute,
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
        path: AppRoutesConstants.homeRoute,
        name: AppRoutesConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.registerRoute,
        name: AppRoutesConstants.registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.additionalRegisterInfoRoute,
        name: AppRoutesConstants.additionalRegisterInfoRoute,
        builder: (context, state) => const RegisterAdditionalInfoScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.loginRoute,
        name: AppRoutesConstants.loginRoute,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: AppRoutesConstants.forgetPasswordRoute,
        path: AppRoutesConstants.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.mealsRecommendationRoute,
        name: AppRoutesConstants.mealsRecommendationRoute,
        builder: (context, state) => const MealCategoriesPage(),
      ),
      GoRoute(
        path: AppRoutesConstants.exercisesRoute,
        name: AppRoutesConstants.exercisesRoute,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is Muscle) {
            return ExercisePage(
              exercise: ExerciseModel(
                id: extra.id ?? '',
                name: extra.name ?? '',
              ),
            );
          } else if (extra is ExerciseModel) {
            return ExercisePage(exercise: extra);
          }

          // Fallback for null extra (e.g. on hot restart)
          return const ExercisePage(
            exercise: ExerciseModel(
              id: '69d982ef85f6bfa972bf2248',
              name: 'Advanced',
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutesConstants.chatPage,
        name: AppRoutesConstants.chatPage,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ChatPage(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),

      GoRoute(
        path: AppRoutesConstants.changePassword,
        name: AppRoutesConstants.changePassword,
        builder: (context, state) => const ChangePasswordView(),
      ),
      GoRoute(
        path: AppRoutesConstants.mealDetailPage,
        name: AppRoutesConstants.mealDetailPage,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is String) {
            return MealDetailPage(mealId: extra);
          }
          return const MealDetailPage(mealId: '');
        },
      ),
    ],
  );
}
