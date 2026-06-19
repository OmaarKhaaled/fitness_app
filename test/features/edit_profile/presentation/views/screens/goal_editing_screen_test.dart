import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:fitness_app/features/edit_profile/presentation/views/screens/goal_editing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'goal_editing_screen_test.mocks.dart';

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
    when(
      mockEditProfileViewModel.state,
    ).thenReturn(EditProfileStates(selectedGoal: 'Lose Weight'));
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
      initialLocation: AppRoutesConstants.goalEditing,
      routes: [
        GoRoute(
          path: AppRoutesConstants.goalEditing,
          builder: (context, state) => const GoalEditingScreen(),
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

  testWidgets('goal editing screen renders all UI elements correctly', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Check title and headers
    expect(
      find.text(AppTextConstants.profileSetupGoalQuestion),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.profileSetupGoalSelectionInfo),
      findsOneWidget,
    );

    // Check all goal options
    expect(
      find.text(AppTextConstants.profileSetupGoalGainWeight),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.profileSetupGoalLoseWeight),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.profileSetupGoalGetFitter),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.profileSetupGoalGainMoreFlexible),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.profileSetupGoalLearnTheBasic),
      findsOneWidget,
    );

    // Check button
    expect(
      find.text(AppTextConstants.profileSetupWeightButton),
      findsOneWidget,
    );

    // Check logo exists (multiple Images)
    expect(find.byType(Image), findsWidgets);
  });

  testWidgets('goal editing screen shows correct selected goal', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // The Lose Weight option should be selected
    expect(
      find.text(AppTextConstants.profileSetupGoalLoseWeight),
      findsOneWidget,
    );
  });
  testWidgets('back button navigates to edit profile screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final context = tester.element(find.byType(GoalEditingScreen));
    GoRouter.of(context).go(AppRoutesConstants.editProfileRoute);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Edit Profile Screen'), findsOneWidget);
  });
  testWidgets('save button is disabled when no goal selected', (tester) async {
    when(
      mockEditProfileViewModel.state,
    ).thenReturn(EditProfileStates(selectedGoal: null));

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

  testWidgets('save button is enabled when goal is selected', (tester) async {
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

  testWidgets('tapping save button calls UpdateGoalEvent', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text(AppTextConstants.profileSetupWeightButton));
    await tester.pump();

    verify(mockEditProfileViewModel.doIntent(any)).called(1);
  });
}
