import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router => GoRouter(
    initialLocation: AppRoutesConstants.onboardingRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.onboardingRoute,
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
}
