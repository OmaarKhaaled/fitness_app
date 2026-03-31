import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router => GoRouter(
    initialLocation: AppRoutesConstants.onboardingRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.onboardingRoute,
        builder: (context, state) => const OnBoardingPage(),
      )    
    ],
  );
}
