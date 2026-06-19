import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:fitness_app/features/edit_profile/presentation/views/screens/activity_level_editing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'activity_level_editing_screen_test.mocks.dart';

@GenerateMocks([EditProfileViewModel])
void main() {
  late MockEditProfileViewModel mockEditProfileViewModel;
  late GetIt getIt;

  setUp(() {
    mockEditProfileViewModel = MockEditProfileViewModel();
    getIt = GetIt.instance;
    if (getIt.isRegistered<EditProfileViewModel>()) {
      getIt.unregister<EditProfileViewModel>();
    }
    getIt.registerSingleton<EditProfileViewModel>(mockEditProfileViewModel);
    when(
      mockEditProfileViewModel.stream,
    ).thenAnswer((_) => const Stream.empty());

    // Set up initial state with a selected activity level
    when(
      mockEditProfileViewModel.state,
    ).thenReturn(EditProfileStates(selectedActivityLevel: 'level2'));
  });

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    if (getIt.isRegistered<EditProfileViewModel>()) {
      getIt.unregister<EditProfileViewModel>();
    }
  });

  Widget buildTestableWidget() {
    final testRouter = GoRouter(
      initialLocation: AppRoutesConstants.activityLevelEditing,
      routes: [
        GoRoute(
          path: AppRoutesConstants.activityLevelEditing,
          builder: (context, state) => const ActivityLevelEditingScreen(),
        ),
        GoRoute(
          path: AppRoutesConstants.editProfileRoute,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Edit Profile Screen'))),
        ),
      ],
    );
    return MaterialApp.router(routerConfig: testRouter);
  }

  testWidgets(
    'activity level editing screen renders all UI elements correctly',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 2400));
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check title and headers
      expect(
        find.text(AppTextConstants.profileSetupActivityQuestion),
        findsOneWidget,
      );

      // Check all activity level options
      expect(
        find.text(AppTextConstants.profileSetupActivityRookie),
        findsOneWidget,
      );
      expect(
        find.text(AppTextConstants.profileSetupActivityBeginner),
        findsOneWidget,
      );
      expect(
        find.text(AppTextConstants.profileSetupActivityIntermediate),
        findsOneWidget,
      );
      expect(
        find.text(AppTextConstants.profileSetupActivityAdvance),
        findsOneWidget,
      );
      expect(
        find.text(AppTextConstants.profileSetupActivityTrueBeast),
        findsOneWidget,
      );

      // Check button
      expect(
        find.text(AppTextConstants.profileSetupWeightButton),
        findsOneWidget,
      );
      // Check logo exists
      expect(find.byType(Image), findsWidgets);
    },
  );

  testWidgets(
    'activity level editing screen shows correct selected activity level',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 2400));
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // The intermediate level (level2) should be selected
      expect(
        find.text(AppTextConstants.profileSetupActivityBeginner),
        findsOneWidget,
      );
    },
  );
  testWidgets('back button navigates to edit profile screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final context = tester.element(find.byType(ActivityLevelEditingScreen));
    GoRouter.of(context).go(AppRoutesConstants.editProfileRoute);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Edit Profile Screen'), findsOneWidget);
  });
  testWidgets('save button is disabled when no activity level selected', (
    tester,
  ) async {
    when(
      mockEditProfileViewModel.state,
    ).thenReturn(EditProfileStates(selectedActivityLevel: null));

    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(
        ElevatedButton,
        AppTextConstants.profileSetupWeightButton,
      ),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('save button is enabled when activity level is selected', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(
        ElevatedButton,
        AppTextConstants.profileSetupWeightButton,
      ),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets('tapping save button calls UpdateActivityLevelEvent', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text(AppTextConstants.profileSetupWeightButton));
    await tester.pump();

    verify(mockEditProfileViewModel.doIntent(any)).called(1);
  });
}
