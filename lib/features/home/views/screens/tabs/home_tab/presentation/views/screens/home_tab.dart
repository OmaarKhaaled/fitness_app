import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/cache_modules/secure_storege_module.dart';
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/core/enums/nav_bar_enum.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/home/view_model/home_events.dart';
import 'package:fitness_app/features/home/view_model/home_view_model.dart';
import 'package:fitness_app/features/home/views/screens/tabs/home_tab/presentation/views/widgets/category_section.dart';
import 'package:fitness_app/features/recommendations/presentation/view/widgets/recommendation_section.dart';
import 'package:fitness_app/features/meals/presentation/view/widgets/meals_section.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.only(top: 60, bottom: 120),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<BaseResponse<String?>>(
                    future: getIt<SecureStorageService>().read(
                      CacheConstants.firstName,
                    ),
                    builder: (context, snapshot) {
                      final firstName = snapshot.data?.whenOrNull(
                        success: (data) => data,
                      );

                      if (firstName != null && firstName.isNotEmpty) {
                        return Text(
                          '${AppTextConstants.greeting} $firstName ,',
                          style: textTheme.bodyLarge?.copyWith(
                            color: AppColors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppTextConstants.letsStartYourDay,
                    style: textTheme.headlineSmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: FutureBuilder<BaseResponse<String?>>(
                    future: getIt<SecureStorageService>().read(
                      CacheConstants.imageUrl,
                    ),
                    builder: (context, snapshot) {
                      final imageUrl = snapshot.data?.whenOrNull(
                        success: (data) => data,
                      );

                      if (imageUrl != null && imageUrl.isNotEmpty) {
                        return CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const Icon(
                              Icons.person_outline,
                              color: AppColors.white,
                              size: 24,
                            );
                          },
                        );
                      }

                      return const Icon(
                        Icons.person_outline,
                        color: AppColors.white,
                        size: 24,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        const CategorySection(),

        const SizedBox(height: 24),

        const RecommendationSection(),

        const SizedBox(height: 24),

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

        const PopularTrainingSection(),
      ],
    );
  }
}
