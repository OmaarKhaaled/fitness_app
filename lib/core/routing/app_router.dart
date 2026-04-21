import 'package:fitness_app/features/home/views/screens/home_screen.dart';

import '../constants/app_routes_constants.dart';
import '../../features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router => GoRouter(
    initialLocation: AppRoutesConstants.homeRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.onboardingRoute,
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
        path: AppRoutesConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
