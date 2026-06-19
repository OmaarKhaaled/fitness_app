import 'package:fitness_app/core/enums/nav_bar_enum.dart';

class HomeStates {
  final NavBarEnum currAppTab;
  final bool isBottomNavVisible;
  HomeStates({required this.currAppTab, this.isBottomNavVisible = true});
  HomeStates copyWith({NavBarEnum? currAppTab, bool? isBottomNavVisible}) {
    return HomeStates(
      currAppTab: currAppTab ?? this.currAppTab,
      isBottomNavVisible: isBottomNavVisible ?? this.isBottomNavVisible,
    );
  }
}
