<<<<<<< feature/app-sections
import 'package:fitness_app/features/home/views/screens/home_screen.dart';

import '../constants/app_routes_constants.dart';
=======

import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/features/auth/login/presentation/views/screens/login_screen.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_additional_info_screen.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_screen.dart';
>>>>>>> development
import '../../features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router => GoRouter(
<<<<<<< feature/app-sections
    initialLocation: AppRoutesConstants.homeRoute,
=======
    initialLocation: AppRoutesConstants.registerRoute,
>>>>>>> development
    routes: [
      GoRoute(
        path: AppRoutesConstants.onboardingRoute,
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
<<<<<<< feature/app-sections
        path: AppRoutesConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
=======
        path: AppRoutesConstants.registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.additionalRegisterInfoRoute,
        builder: (context, state) => const RegisterAdditionalInfoScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.loginRoute,
        builder: (context, state) => const LoginScreen(),
>>>>>>> development
      ),
    ],
  );
}
