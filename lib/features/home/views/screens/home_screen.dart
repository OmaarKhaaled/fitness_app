import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/enums/nav_bar_enum.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/home/view_model/home_events.dart';
import 'package:fitness_app/features/home/view_model/home_states.dart';
import 'package:fitness_app/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel viewModel;
  late ScrollController _scrollController;
  double _lastScrollOffset = 0;
  @override
  void initState() {
    super.initState();
    viewModel = getIt<HomeViewModel>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final currentOffset = _scrollController.offset;
    final isScrollingDown = currentOffset > _lastScrollOffset;
    final isAtTop = currentOffset <= 0;

    if (currentOffset != _lastScrollOffset && !isAtTop) {
      viewModel.doIntent(ScrollDirectionChangedEvent(isScrollingDown));
    }
    _lastScrollOffset = currentOffset;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return BlocProvider<HomeViewModel>.value(
      value: viewModel,
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          final tabs = viewModel.tabs(_scrollController);
          final currentTab = tabs[state.currAppTab.index];
          final scrollableContent =
              NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  final metrics = notification.metrics;
                  final isScrollingDown = metrics.pixels > _lastScrollOffset;
                  final isAtTop = metrics.pixels <= 0;

                  if (metrics.pixels != _lastScrollOffset && !isAtTop) {
                    viewModel.doIntent(
                      ScrollDirectionChangedEvent(isScrollingDown),
                    );
                  }

                  _lastScrollOffset = metrics.pixels;
                  return false;
                },
                child: currentTab,
              );
          return AppScaffold(
            backgroundImage: AppAssets.authBackground,
            alignment: Alignment.topCenter,
            isBottomNavVisible: state.isBottomNavVisible,
            bottomWidget: Container(
              margin: EdgeInsets.only(
                left: 0.09 * width,
                right: 0.09 * width,
                bottom: 0.03 * height,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.05 * width),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.05 * width),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.navBarBg,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.white,
                  unselectedLabelStyle: const TextStyle(fontSize: 0),
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  currentIndex: state.currAppTab.index,
                  onTap: (index) {
                    final tab = NavBarEnum.values[index];
                    viewModel.doIntent(ChangeCurrTabEvent(tab));
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.home,
                        colorFilter: ColorFilter.mode(
                          state.currAppTab == NavBarEnum.home
                              ? AppColors.primary
                              : AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: AppTextConstants.exploreIcon,
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.chatAi,
                        colorFilter: ColorFilter.mode(
                          state.currAppTab == NavBarEnum.chatAi
                              ? AppColors.primary
                              : AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: AppTextConstants.smartCoachIcon,
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.workout,
                        colorFilter: ColorFilter.mode(
                          state.currAppTab == NavBarEnum.workout
                              ? AppColors.primary
                              : AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: AppTextConstants.workoutsIcon,
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.profile,
                        colorFilter: ColorFilter.mode(
                          state.currAppTab == NavBarEnum.profile
                              ? AppColors.primary
                              : AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: AppTextConstants.profileIcon,
                    ),
                  ],
                ),
              ),
            ),
            child: scrollableContent,
          );
        },
      ),
    );
  }
}
