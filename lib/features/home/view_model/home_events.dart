import 'package:fitness_app/core/enums/nav_bar_enum.dart';

sealed class HomeEvents {}

class ChangeCurrTabEvent extends HomeEvents {
  final NavBarEnum tab;
  ChangeCurrTabEvent(this.tab);
}

class ScrollDirectionChangedEvent extends HomeEvents {
  final bool isScrollingDown;
  ScrollDirectionChangedEvent(this.isScrollingDown);
}
