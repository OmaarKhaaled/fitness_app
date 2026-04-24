import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/widgets/gender_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderPage extends StatelessWidget {
  final PageController pageController;
  const GenderPage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<RegisterViewModel, RegisterStates>(
      builder: (context, state) {
        final selectedGender = state.selectedGender;
        final isButtonEnabled = selectedGender != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0.04 * width),
              child: Text(
                AppTextConstants.profileSetupTellUs,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.04 * width),
              child: Text(
                AppTextConstants.profileSetupGenderSelectInstruction,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 0.02 * height),
            BlurCard(
              child: Column(
                children: [
                  SizedBox(height: 0.03 * height),
                  GenderSelectionWidget(
                    isSelected: selectedGender == 'male',
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectGenderEvent('male'),
                      );
                    },
                    genderIconPath: AppIcons.maleSymbol,
                    genderName: AppTextConstants.profileSetupGenderMale,
                  ),
                  SizedBox(height: 0.03 * height),
                  GenderSelectionWidget(
                    isSelected: selectedGender == 'female',
                    onTap: () {
                      context.read<RegisterViewModel>().doIntent(
                        SelectGenderEvent('female'),
                      );
                    },
                    genderIconPath: AppIcons.femaleSymbol,
                    genderName: AppTextConstants.profileSetupGenderFemale,
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
                                isButtonEnabled
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
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
                        child: Text(AppTextConstants.profileSetupGenderButton),
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
