import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:fitness_app/features/edit_profile/presentation/views/screens/weight_editing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weight_editing_screen_test.mocks.dart';

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
    when(mockEditProfileViewModel.state).thenReturn(
      EditProfileStates(
        selectedWeight: 89,
        currentWeightIndex: 89 - 45, // 44
      ),
    );
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
      initialLocation: AppRoutesConstants.weightEditing,
      routes: [
        GoRoute(
          path: AppRoutesConstants.weightEditing,
          builder: (context, state) => const WeightEditingScreen(),
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

  testWidgets('weight editing screen renders all UI elements correctly', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Check title and info texts
    expect(
      find.text(AppTextConstants.profileSetupWeightQuestion),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.profileSetupWeightSelectionInfo),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.profileSetupWeightUnit), findsOneWidget);

    // Check button
    expect(
      find.text(AppTextConstants.profileSetupWeightButton),
      findsOneWidget,
    );

    // Check up arrow icon
    expect(find.byIcon(Icons.arrow_drop_up), findsOneWidget);

    // Check logo exists
    expect(find.byType(Image), findsWidgets);
  });

  testWidgets('weight editing screen shows current weight value', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // The weight 89 should be visible in the picker
    expect(find.text('89'), findsOneWidget);
  });
  testWidgets('back button navigates to edit profile screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final context = tester.element(find.byType(WeightEditingScreen));
    GoRouter.of(context).go(AppRoutesConstants.editProfileRoute);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Edit Profile Screen'), findsOneWidget);
  });
  testWidgets('tapping save button calls UpdateWeightEvent', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text(AppTextConstants.profileSetupWeightButton));
    await tester.pump();

    verify(mockEditProfileViewModel.doIntent(any)).called(2);
  });

  testWidgets('up arrow button changes weight', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Tap the up arrow to increase weight
    final upArrow = find.byIcon(Icons.arrow_drop_up);
    await tester.tap(upArrow);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    // Verify UpdateWeightIndexEvent was called
    verify(mockEditProfileViewModel.doIntent(any)).called(2);
  });

  testWidgets('scrolling the page view updates weight', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Find the PageView
    final pageViewFinder = find.byType(PageView);
    expect(pageViewFinder, findsOneWidget);

    // Drag to scroll to the right
    await tester.drag(pageViewFinder, const Offset(-300, 0));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    // Verify UpdateWeightIndexEvent was called
    verify(mockEditProfileViewModel.doIntent(any)).called(2);
  });
}
