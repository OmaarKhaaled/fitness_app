import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view/screens/forget_password_screen.dart';
import 'package:fitness_app/features/home/views/screens/home_screen.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_additional_info_screen.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_screen.dart';
import 'package:fitness_app/features/meals/presentation/view/pages/meals_recommendation_page.dart';
import '../../features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:fitness_app/features/auth/login/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.loginRoute,
    routes: [
      GoRoute(
        name: AppRoutesConstants.onboardingRoute,
        path: AppRoutesConstants.onboardingRoute,
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
        path: AppRoutesConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.additionalRegisterInfoRoute,
        builder: (context, state) => const RegisterAdditionalInfoScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.loginRoute,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: AppRoutesConstants.forgetPasswordRoute,
        path: AppRoutesConstants.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.mealsRecommendationRoute,
        builder: (context, state) => const MealsRecommendationPage(),
      ),
    ],
  );
}
