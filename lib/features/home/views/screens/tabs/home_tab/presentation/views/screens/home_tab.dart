import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/enums/nav_bar_enum.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/home/view_model/home_events.dart';
import 'package:fitness_app/features/home/view_model/home_view_model.dart';
import 'package:fitness_app/features/home/views/screens/tabs/home_tab/presentation/views/widgets/category_section.dart';
import 'package:fitness_app/features/meals/presentation/food_category/view/widgets/meals_section.dart';
import 'package:fitness_app/features/recommendations/presentation/view/widgets/recommendation_section.dart';
import 'package:fitness_app/features/popular_tarining/presentation/view/widgets/popular_training_section.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/workouts_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeTab extends StatefulWidget {
  final ScrollController scrollController;
  const HomeTab({super.key, required this.scrollController});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.only(top: 60, bottom: 120),
      children: [
        // Greeting header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi there,',
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Let's Start Your Day",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        WorkoutsSection(
          onSeeAllTapped: () {
            final homeViewModel = context.read<HomeViewModel>();
            homeViewModel.doIntent(ChangeCurrTabEvent(NavBarEnum.workout));
          },
        ),

        const SizedBox(height: 32),

        MealsSection(
          onSeeAllTapped: () {
            context.push(AppRoutesConstants.mealsRecommendationRoute);
          },
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
