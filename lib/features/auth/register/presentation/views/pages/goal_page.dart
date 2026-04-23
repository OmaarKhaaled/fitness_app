import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/widgets/radio_option_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalPage extends StatelessWidget {
  final PageController pageController;
  const GoalPage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<RegisterViewModel, RegisterStates>(
      builder: (context, state) {
        final selectedGoal = state.selectedGoal;
        final isButtonEnabled = selectedGoal != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0.04 * width),
              child: Text(
                AppTextConstants.profileSetupGoalQuestion,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.04 * width),
              child: Text(
                AppTextConstants.profileSetupGoalSelectionInfo,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 0.02 * height),
            BlurCard(
              child: Column(
                children: [
                  SizedBox(height: 0.03 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupGoalGainWeight,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectGoalEvent('Gain Weight'),
                      );
                    },
                    isSelected: selectedGoal == 'Gain Weight',
                  ),
                  SizedBox(height: 0.02 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupGoalLoseWeight,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectGoalEvent('Lose Weight'),
                      );
                    },
                    isSelected: selectedGoal == 'Lose Weight',
                  ),
                  SizedBox(height: 0.02 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupGoalGetFitter,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectGoalEvent('Get Fitter'),
                      );
                    },
                    isSelected: selectedGoal == 'Get Fitter',
                  ),
                  SizedBox(height: 0.02 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupGoalGainMoreFlexible,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectGoalEvent('Gain More Flexible'),
                      );
                    },
                    isSelected: selectedGoal == 'Gain More Flexible',
                  ),
                  SizedBox(height: 0.02 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupGoalLearnTheBasic,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectGoalEvent('Learn The Basic'),
                      );
                    },
                    isSelected: selectedGoal == 'Learn The Basic',
                  ),
                  SizedBox(height: 0.03 * height),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style
                            ?.copyWith(
                              backgroundColor: WidgetStateProperty.all(
                                AppColors.primary,
                              ),
                              foregroundColor: WidgetStateProperty.all(
                                AppColors.white,
                              ),
                            ),
                        onPressed: isButtonEnabled
                            ? () {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              }
                            : null,
                        child: Text(AppTextConstants.profileSetupGoalButton),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
