import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/features/auth/register/presentation/views/widgets/radio_option_selection_widget.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:go_router/go_router.dart';

class GoalEditingScreen extends StatefulWidget {
  const GoalEditingScreen({super.key});

  @override
  State<GoalEditingScreen> createState() => _GoalEditingScreenState();
}

class _GoalEditingScreenState extends State<GoalEditingScreen> {
  late EditProfileViewModel _viewModel;
  String? _selectedGoal;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<EditProfileViewModel>();
    final currentGoal = _viewModel.state.profileState?.data?.userModel?.goal;
    if (currentGoal != null) {
      _selectedGoal = currentGoal;
      if (_viewModel.state.selectedGoal != currentGoal) {
        _viewModel.doIntent(SelectGoalEvent(currentGoal));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return BlocProvider<EditProfileViewModel>.value(
      value: _viewModel,
      child: BlocConsumer<EditProfileViewModel, EditProfileStates>(
        listener: (context, state) {
          final editProfileState = state.editProfileState;

          if (editProfileState?.isLoading == true) {
            UiUtils.showLoading(context);
          } else if (editProfileState?.isLoading == false &&
              editProfileState?.data != null &&
              state.isEditSuccess) {
            UiUtils.hideLoading(context);
            UiUtils.showSuccessMsg(context, editProfileState!.data!.message!);
            _viewModel.doIntent(ResetEditSuccessEvent());
            context.go(AppRoutesConstants.editProfileRoute);
            return;
          } else if (editProfileState?.isLoading == false &&
              editProfileState?.errorMessage != null) {
            UiUtils.hideLoading(context);
            UiUtils.showErrorMsg(context, editProfileState!.errorMessage!);
          }
        },
        builder: (context, state) {
          final selectedGoal = state.selectedGoal ?? _selectedGoal;
          final isButtonEnabled = selectedGoal != null;
          
          return AppScaffold(
            backgroundImage: AppAssets.authBackground,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 0.06 * height,
                    left: 0.04 * width,
                    right: 0.04 * width,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.go(AppRoutesConstants.editProfileRoute);
                        },
                        child: Container(
                          width: 0.06 * width,
                          height: 0.06 * width,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              AppIcons.backArrow,
                              color: AppColors.white,
                              width: 0.03 * width,
                              height: 0.03 * width,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Image.asset(AppAssets.superFitness),
                        ),
                      ),
                      SizedBox(width: 0.06 * width),
                    ],
                  ),
                ),
                SizedBox(height: 0.15 * height),
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
                          _viewModel.doIntent(SelectGoalEvent('Gain Weight'));
                        },
                        isSelected: selectedGoal == 'Gain Weight',
                      ),
                      SizedBox(height: 0.02 * height),
                      RadioOptionSelectionWidget(
                        option: AppTextConstants.profileSetupGoalLoseWeight,
                        onTap: () {
                          _viewModel.doIntent(SelectGoalEvent('Lose Weight'));
                        },
                        isSelected: selectedGoal == 'Lose Weight',
                      ),
                      SizedBox(height: 0.02 * height),
                      RadioOptionSelectionWidget(
                        option: AppTextConstants.profileSetupGoalGetFitter,
                        onTap: () {
                          _viewModel.doIntent(SelectGoalEvent('Get Fitter'));
                        },
                        isSelected: selectedGoal == 'Get Fitter',
                      ),
                      SizedBox(height: 0.02 * height),
                      RadioOptionSelectionWidget(
                        option: AppTextConstants.profileSetupGoalGainMoreFlexible,
                        onTap: () {
                          _viewModel.doIntent(SelectGoalEvent('Gain More Flexible'));
                        },
                        isSelected: selectedGoal == 'Gain More Flexible',
                      ),
                      SizedBox(height: 0.02 * height),
                      RadioOptionSelectionWidget(
                        option: AppTextConstants.profileSetupGoalLearnTheBasic,
                        onTap: () {
                          _viewModel.doIntent(SelectGoalEvent('Learn The Basic'));
                        },
                        isSelected: selectedGoal == 'Learn The Basic',
                      ),
                      SizedBox(height: 0.03 * height),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              backgroundColor: WidgetStateProperty.all(
                                isButtonEnabled ? AppColors.primary : AppColors.textSecondary,
                              ),
                            ),
                            onPressed: isButtonEnabled
                                ? () {
                                    _viewModel.doIntent(UpdateGoalEvent(selectedGoal));
                                  }
                                : null,
                            child: Text(AppTextConstants.profileSetupWeightButton),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}