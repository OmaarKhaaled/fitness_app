import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/enums/nav_bar_enum.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/features/home/view_model/home_states.dart';
import 'package:fitness_app/features/home/view_model/home_view_model.dart';
import 'package:fitness_app/features/home/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen_test.mocks.dart';

class TestAssetLoader extends AssetLoader {
  const TestAssetLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      'bottom_nav_bar': {
        'explore': 'Explore',
        'smart_coach': 'Smart Coach',
        'workouts': 'Workouts',
        'profile': 'Profile',
      },
    };
  }
}

@GenerateMocks([HomeViewModel])
void main() {
  late MockHomeViewModel mockHomeViewModel;
  late GetIt getIt;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    mockHomeViewModel = MockHomeViewModel();
    getIt = GetIt.instance;
    if (getIt.isRegistered<HomeViewModel>()) {
      getIt.unregister<HomeViewModel>();
    }
    getIt.registerSingleton<HomeViewModel>(mockHomeViewModel);
    when(mockHomeViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(
      mockHomeViewModel.state,
    ).thenReturn(HomeStates(currAppTab: NavBarEnum.home));
    when(mockHomeViewModel.tabs(any)).thenReturn([
      Container(key: const Key('home_tab'), child: const Text('Home Tab')),
      Container(key: const Key('coach_tab'), child: const Text('Coach Tab')),
      Container(
        key: const Key('workouts_tab'),
        child: const Text('Workouts Tab'),
      ),
      Container(
        key: const Key('profile_tab'),
        child: const Text('Profile Tab'),
      ),
    ]);
  });
  tearDown(() {
    if (getIt.isRegistered<HomeViewModel>()) {
      getIt.unregister<HomeViewModel>();
    }
  });
  Widget buildTestableWidget() {
    final testRouter = GoRouter(
      initialLocation: AppRoutesConstants.homeRoute,
      routes: [
        GoRoute(
          path: AppRoutesConstants.homeRoute,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      assetLoader: const TestAssetLoader(),
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: testRouter,
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
          );
        },
      ),
    );
  }

  testWidgets('home screen renders successfully in initial state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();
    expect(find.byType(AppScaffold), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(
      find.byType(NotificationListener<ScrollUpdateNotification>),
      findsOneWidget,
    );
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text(AppTextConstants.exploreIcon), findsNWidgets(1));
    expect(find.text(AppTextConstants.smartCoachIcon), findsNWidgets(1));
    expect(find.text(AppTextConstants.workoutsIcon), findsNWidgets(1));
    expect(find.text(AppTextConstants.profileIcon), findsNWidgets(1));
    expect(find.byType(SvgPicture), findsNWidgets(4));
    expect(find.text('Home Tab'), findsOneWidget);
    expect(find.text('Coach Tab'), findsNothing);
    expect(find.text('Workouts Tab'), findsNothing);
    expect(find.text('Profile Tab'), findsNothing);
  });
}
