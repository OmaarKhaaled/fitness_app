import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view/screens/forget_password_screen.dart';
import 'package:fitness_app/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.onboardingRoute,
    routes: [
      GoRoute(
        name: AppRoutesConstants.onboardingRoute,
        path: AppRoutesConstants.onboardingRoute,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: AppRoutesConstants.forgetPasswordRoute,
        path: AppRoutesConstants.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
    ],
  );
}
