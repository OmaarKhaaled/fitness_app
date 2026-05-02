import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/enums/nav_bar_enum.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/home/view_model/home_events.dart';
import 'package:fitness_app/features/home/view_model/home_view_model.dart';
import 'package:fitness_app/features/home/views/screens/tabs/home_tab/presentation/views/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTextConstants.category,
            style: textTheme.titleLarge!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CategoryItem(
                    title: AppTextConstants.gym,
                    image: AppAssets.gymCategory,
                    onTap: () {},
                  ),
                ),
                _buildDivider(),
                Expanded(
                  child: CategoryItem(
                    title: AppTextConstants.fitness,
                    image: AppAssets.fitnessCategory,
                    onTap: () {},
                  ),
                ),
                _buildDivider(),
                Expanded(
                  child: CategoryItem(
                    title: AppTextConstants.yoga,
                    image: AppAssets.yogaCategory,
                    onTap: () {},
                  ),
                ),
                _buildDivider(),
                Expanded(
                  child: CategoryItem(
                    title: AppTextConstants.aerobics,
                    image: AppAssets.aerobicsCategory,
                    onTap: () {},
                  ),
                ),
                _buildDivider(),
                Expanded(
                  child: CategoryItem(
                    title: AppTextConstants.trainer,
                    image: AppAssets.trainerCategory,
                    onTap: () {
                      final homeViewModel = context.read<HomeViewModel>();
                      homeViewModel.doIntent(
                        ChangeCurrTabEvent(NavBarEnum.chatAi),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.white.withValues(alpha: 0.1),
    );
  }
}
