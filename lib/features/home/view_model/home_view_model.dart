import 'package:fitness_app/core/enums/nav_bar_enum.dart';
import 'package:fitness_app/features/home/view_model/home_events.dart';
import 'package:fitness_app/features/home/view_model/home_states.dart';
import 'package:fitness_app/features/home/views/screens/tabs/home_tab/presentation/views/screens/home_tab.dart';
import 'package:fitness_app/features/home/views/screens/tabs/profile_tab/presentation/views/screens/profile_tab.dart';
import 'package:fitness_app/features/home/views/screens/tabs/workouts_tab/presentation/views/screens/workouts_tab.dart';
import 'package:fitness_app/features/smart_coach/presentation/views/pages/smart_coach_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(HomeStates(currAppTab: NavBarEnum.home));
  List<Widget> tabs(ScrollController scrollController) => [
    HomeTab(scrollController: scrollController),
    SmartCoachTab(scrollController: scrollController),
    WorkoutsTab(scrollController: scrollController),
    ProfileTab(),
  ];
  void doIntent(HomeEvents event) {
    switch (event) {
      case ChangeCurrTabEvent():
        _switchTab(event.tab);
      case ScrollDirectionChangedEvent():
        _onScrollDirectionChanged(event.isScrollingDown);
    }
  }

  void _switchTab(NavBarEnum tab) {
    emit(state.copyWith(currAppTab: tab));
  }

  void _onScrollDirectionChanged(bool isScrollingDown) {
    if (isScrollingDown && state.isBottomNavVisible) {
      emit(state.copyWith(isBottomNavVisible: false));
    } else if (!isScrollingDown && !state.isBottomNavVisible) {
      emit(state.copyWith(isBottomNavVisible: true));
    }
  }
}
