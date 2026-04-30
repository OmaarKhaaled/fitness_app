import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:go_router/go_router.dart';

class WeightEditingScreen extends StatefulWidget {
  const WeightEditingScreen({super.key});

  @override
  State<WeightEditingScreen> createState() => _WeightEditingScreenState();
}

class _WeightEditingScreenState extends State<WeightEditingScreen> {
  late PageController _horizontalController;
  final int minWeight = 45;
  final int maxWeight = 150;
  late EditProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<EditProfileViewModel>();
    
    final currentWeight = _viewModel.state.profileState?.data?.userModel?.weight;
    final savedWeight = currentWeight ?? 90;
    final savedIndex = savedWeight - minWeight;
    if (_viewModel.state.currentWeightIndex != savedIndex) {
      _viewModel.doIntent(UpdateWeightIndexEvent(savedIndex, savedWeight));
    }
    _horizontalController = PageController(
      initialPage: savedIndex,
      viewportFraction: 0.18,
    );
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  double _getFontSize(int distance) {
    switch (distance) {
      case 0: return 44;
      case 1: return 33;
      case 2: return 25;
      case 3: return 16;
      default: return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final totalItems = maxWeight - minWeight + 1;

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
          } else if (editProfileState?.isLoading == false &&
              editProfileState?.errorMessage != null) {
            UiUtils.hideLoading(context);
            UiUtils.showErrorMsg(context, editProfileState!.errorMessage!);
          }
        },
        builder: (context, state) {
          final currentIndex = state.currentWeightIndex;
          
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
                SizedBox(height: 0.2 * height),
                Padding(
                  padding: EdgeInsets.only(left: 0.04 * width),
                  child: Text(
                    AppTextConstants.profileSetupWeightQuestion,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.04 * width),
                  child: Text(
                    AppTextConstants.profileSetupWeightSelectionInfo,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: 0.02 * height),
                BlurCard(
                  child: Column(
                    children: [
                      SizedBox(height: 0.03 * height),
                      Text(
                        AppTextConstants.profileSetupWeightUnit,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 0.02 * height),
                      SizedBox(
                        height: 0.09 * height,
                        child: PageView.builder(
                          controller: _horizontalController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: (index) {
                            final selectedWeight = index + minWeight;
                            _viewModel.doIntent(UpdateWeightIndexEvent(index, selectedWeight));
                          },
                          itemCount: totalItems,
                          itemBuilder: (context, index) {
                            final weight = index + minWeight;
                            final distance = (currentIndex - index).abs();
                            final fontSize = _getFontSize(distance);
                            final isCenter = distance == 0;
                            final isVisible = distance <= 5;
                            
                            if (!isVisible) {
                              return const SizedBox.shrink();
                            }
                            
                            return TweenAnimationBuilder<double>(
                              tween: Tween<double>(
                                begin: distance == 0 ? 1.05 : (distance == 1 ? 1.0 : 0.85),
                                end: isCenter
                                    ? 1.05
                                    : (distance == 1 ? 1.0 : (distance == 2 ? 0.85 : 0.7)),
                              ),
                              duration: const Duration(milliseconds: 200),
                              builder: (context, scale, child) {
                                return Container(
                                  width: 85,
                                  alignment: Alignment.center,
                                  child: Transform.scale(
                                    scale: scale,
                                    child: child,
                                  ),
                                );
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  weight.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w800,
                                    color: isCenter ? AppColors.primary : Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (currentIndex < totalItems - 1) {
                            _horizontalController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_drop_up,
                          color: AppColors.primary,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 0.04 * height),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _viewModel.doIntent(UpdateWeightEvent(state.selectedWeight));
                            },
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
