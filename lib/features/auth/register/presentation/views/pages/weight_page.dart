import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightPage extends StatefulWidget {
  final PageController pageController;
  const WeightPage({super.key, required this.pageController});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  late PageController _horizontalController;
  final int minWeight = 45;
  final int maxWeight = 150;
  int _selectedWeight = 90;
  int _currentIndex = 45;
  @override
  void initState() {
    super.initState();
    final viewmodel = context.read<RegisterViewModel>();
    final savedWeight = viewmodel.state.selectedWeight;
    _selectedWeight = savedWeight;
    _currentIndex = savedWeight - minWeight;
    _horizontalController = PageController(
      initialPage: _currentIndex,
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
      case 0:
        return 44;
      case 1:
        return 33;
      case 2:
        return 25;
      case 3:
        return 16;
      default:
        return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final totalItems = maxWeight - minWeight + 1;
    return BlocBuilder<RegisterViewModel, RegisterStates>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.primary),
                  ),
                  SizedBox(height: 0.02 * height),
                  SizedBox(
                    height: 0.09 * height,
                    child: PageView.builder(
                      controller: _horizontalController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        _currentIndex = index;
                        _selectedWeight = index + minWeight;
                        context.read<RegisterViewModel>().doIntent(
                          SelectWeightEvent(_selectedWeight),
                        );
                      },
                      itemCount: totalItems,
                      itemBuilder: (context, index) {
                        final weight = index + minWeight;
                        final distance = (_currentIndex - index).abs();
                        final fontSize = _getFontSize(distance);
                        final isCenter = distance == 0;
                        final isVisible = distance <= 5;
                        if (!isVisible) {
                          return const SizedBox.shrink();
                        }
                        return Container(
                          width: 85,
                          alignment: Alignment.center,
                          child: Transform.scale(
                            scale: isCenter
                                ? 1.05
                                : (distance == 1
                                      ? 1.0
                                      : (distance == 2 ? 0.85 : 0.7)),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                weight.toString(),
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w800,
                                      color: isCenter
                                          ? AppColors.primary
                                          : Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_currentIndex < totalItems - 1) {
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
                          if (_selectedWeight == 90) {
                            context.read<RegisterViewModel>().doIntent(
                              SelectWeightEvent(_selectedWeight),
                            );
                          }
                          widget.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                        child: Text(AppTextConstants.profileSetupWeightButton),
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
