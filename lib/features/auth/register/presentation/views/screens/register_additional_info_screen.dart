import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/activity_level_page.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/age_page.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/gender_page.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/goal_page.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/height_page.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/weight_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RegisterAdditionalInfoScreen extends StatefulWidget {
  const RegisterAdditionalInfoScreen({super.key});

  @override
  State<RegisterAdditionalInfoScreen> createState() =>
      _RegisterAdditionalInfoScreenState();
}

class _RegisterAdditionalInfoScreenState
    extends State<RegisterAdditionalInfoScreen> {
  late PageController _pageController;
  late RegisterViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _viewModel = getIt<RegisterViewModel>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocProvider<RegisterViewModel>.value(
      value: _viewModel,
      child: BlocConsumer<RegisterViewModel, RegisterStates>(
        builder: (context, state) {
          final currentIndex = state.currentPageIndex;
          const totalPages = 6;
          final hasSelectedGender = state.selectedGender != null;
          final bool showBackButton =
              (currentIndex == 0 && hasSelectedGender) || currentIndex > 0;
          VoidCallback? _getBackButtonAction() {
            if (!showBackButton) return null;
            if (currentIndex == 0 && hasSelectedGender) {
              return () => context.go(AppRoutesConstants.registerRoute);
            }
            return () {
              _viewModel.doIntent(PreviousPageEvent());
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            };
          }

          return AppScaffold(
            backgroundImage: AppAssets.authBackground,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: 0.06 * height),
                if (currentIndex == 0 && !hasSelectedGender)
                  Image.asset(AppAssets.superFitness)
                else
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: _getBackButtonAction(),
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
                SizedBox(height: 0.16 * height),
                CircularPercentIndicator(
                  radius: 0.1 * width,
                  lineWidth: 5,
                  percent: (currentIndex + 1) / totalPages,
                  center: Text(
                    '${currentIndex + 1}/$totalPages',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  progressColor: AppColors.primary,
                  fillColor: AppColors.transparent,
                  backgroundColor: AppColors.transparent,
                ),
                SizedBox(height: 0.02 * height),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      if (index != currentIndex) {
                        _viewModel.doIntent(NextPageEvent());
                      }
                    },
                    children: [
                      GenderPage(pageController: _pageController),
                      AgePage(pageController: _pageController),
                      WeightPage(pageController: _pageController),
                      HeightPage(pageController: _pageController),
                      GoalPage(pageController: _pageController),
                      ActivityLevelPage(
                        onTap: () {
                          _viewModel.doIntent(SubmitRegistrationEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          final registerState = state.registerState;
          if (registerState?.isLoading == true) {
            UiUtils.showLoading(context);
          } else if (registerState?.isLoading == false &&
              registerState?.data != null) {
            UiUtils.hideLoading(context);
            UiUtils.showSuccessMsg(context, registerState!.data!.message!);
            context.go(AppRoutesConstants.loginRoute);
          } else if (registerState?.isLoading == false &&
              registerState?.isError == true) {
            UiUtils.hideLoading(context);
            UiUtils.showErrorMsg(context, 'Error');
          }
        },
      ),
    );
  }
}
