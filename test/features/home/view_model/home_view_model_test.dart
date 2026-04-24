import 'package:fitness_app/core/enums/nav_bar_enum.dart';
import 'package:fitness_app/features/home/view_model/home_events.dart';
import 'package:fitness_app/features/home/view_model/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeViewModel homeViewModel;
  setUp(() {
    homeViewModel = HomeViewModel();
  });
  tearDownAll(() {
    homeViewModel.close();
  });
  group('test cases of view model', () {
    test('checking that initial state is home tab(explore tab)', () {
      expect(homeViewModel.state.currAppTab, NavBarEnum.home);
      expect(homeViewModel.state.currAppTab.index, isZero);
    });
    test('checking switching between multiple tabs', () {
      homeViewModel.doIntent(ChangeCurrTabEvent(NavBarEnum.chatAi));
      expect(homeViewModel.state.currAppTab, NavBarEnum.chatAi);
      expect(homeViewModel.state.currAppTab.index, equals(1));
      homeViewModel.doIntent(ChangeCurrTabEvent(NavBarEnum.profile));
      expect(homeViewModel.state.currAppTab, NavBarEnum.profile);
      expect(homeViewModel.state.currAppTab.index, equals(3));
    });
    test('checking that pressing the same tab twice is handled properly', () {
      homeViewModel.doIntent(ChangeCurrTabEvent(NavBarEnum.chatAi));
      homeViewModel.doIntent(ChangeCurrTabEvent(NavBarEnum.chatAi));
      expect(homeViewModel.state.currAppTab, NavBarEnum.chatAi);
      expect(homeViewModel.state.currAppTab.index, equals(1));
    });
  });
  test('checking that scrolling down hides the bottom navigation bar', () {
    expect(homeViewModel.state.isBottomNavVisible, true);
    homeViewModel.doIntent(ScrollDirectionChangedEvent(true));
    expect(homeViewModel.state.isBottomNavVisible, false);
  });

  test('checking that scrolling up shows the bottom navigation bar', () {
    homeViewModel.doIntent(ScrollDirectionChangedEvent(true));
    expect(homeViewModel.state.isBottomNavVisible, false);

    homeViewModel.doIntent(ScrollDirectionChangedEvent(false));
    expect(homeViewModel.state.isBottomNavVisible, true);
  });
}
