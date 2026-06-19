import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/widgets/radio_option_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityLevelPage extends StatelessWidget {
  final VoidCallback onTap;
  const ActivityLevelPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<RegisterViewModel, RegisterStates>(
      builder: (context, state) {
        final selectedActivityLevel = state.selectedActivityLevel;
        final isButtonEnabled = selectedActivityLevel != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0.04 * width),
              child: Text(
                AppTextConstants.profileSetupActivityQuestion,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: 0.03 * height),
            BlurCard(
              child: Column(
                children: [
                  SizedBox(height: 0.03 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupActivityRookie,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectActivityLevelEvent('level1'),
                      );
                    },
                    isSelected: selectedActivityLevel == 'level1',
                  ),
                  SizedBox(height: 0.02 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupActivityBeginner,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectActivityLevelEvent('level2'),
                      );
                    },
                    isSelected: selectedActivityLevel == 'level2',
                  ),
                  SizedBox(height: 0.02 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupActivityIntermediate,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectActivityLevelEvent('level3'),
                      );
                    },
                    isSelected: selectedActivityLevel == 'level3',
                  ),
                  SizedBox(height: 0.02 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupActivityAdvance,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectActivityLevelEvent('level4'),
                      );
                    },
                    isSelected: selectedActivityLevel == 'level4',
                  ),
                  SizedBox(height: 0.02 * height),
                  RadioOptionSelectionWidget(
                    option: AppTextConstants.profileSetupActivityTrueBeast,
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectActivityLevelEvent('level5'),
                      );
                    },
                    isSelected: selectedActivityLevel == 'level5',
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
                        onPressed:
                            (isButtonEnabled &&
                                state.registerState?.isLoading != true)
                            ? onTap
                            : null,
                        child: state.registerState?.isLoading == true
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(AppTextConstants.profileSetupActivityButton),
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
