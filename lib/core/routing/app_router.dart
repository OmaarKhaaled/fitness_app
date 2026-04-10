import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/features/auth/login/presentation/views/screens/login_screen.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_additional_info_screen.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_screen.dart';
import 'package:fitness_app/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router => GoRouter(
    initialLocation: AppRoutesConstants.registerRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.onboardingRoute,
        builder: (context, state) => const OnboardingScreen(),
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
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
