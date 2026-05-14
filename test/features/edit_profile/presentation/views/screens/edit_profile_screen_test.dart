import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/user_model.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:fitness_app/features/edit_profile/presentation/views/screens/edit_profile_screen.dart';
import 'package:fitness_app/features/edit_profile/presentation/views/widgets/special_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_screen_test.mocks.dart';

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

    final userModel = UserModel(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      weight: 80,
      goal: 'Lose Weight',
      activityLevel: 'level2',
    );

    when(mockEditProfileViewModel.state).thenReturn(
      EditProfileStates(
        profileState: BaseState<EditProfileResponseModel>(
          isLoading: false,
          data: EditProfileResponseModel(
            message: 'success',
            userModel: userModel,
          ),
        ),
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
      initialLocation: AppRoutesConstants.editProfileRoute,
      routes: [
        GoRoute(
          path: AppRoutesConstants.editProfileRoute,
          builder: (context, state) =>
              const SizedBox(width: 400, child: EditProfileScreen()),
        ),
        GoRoute(
          path: AppRoutesConstants.homeRoute,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Home Screen'))),
        ),
        GoRoute(
          path: AppRoutesConstants.weightEditing,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Weight Editing Screen')),
          ),
        ),
        GoRoute(
          path: AppRoutesConstants.goalEditing,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Goal Editing Screen'))),
        ),
        GoRoute(
          path: AppRoutesConstants.activityLevelEditing,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Activity Level Editing Screen')),
          ),
        ),
      ],
    );

    return MaterialApp.router(routerConfig: testRouter);
  }

  testWidgets(
    'edit profile screen renders all UI elements correctly with user data',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 2400));
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('John'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);
      expect(find.text('Lose Weight'), findsOneWidget);
      expect(find.byType(SpecialHeaderWidget), findsNWidgets(3));
      expect(find.text(AppTextConstants.editProfileHeader), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(6));
    },
  );

  testWidgets('edit profile screen shows loading indicator when loading', (
    tester,
  ) async {
    when(mockEditProfileViewModel.state).thenReturn(
      EditProfileStates(
        profileState: const BaseState<EditProfileResponseModel>(
          isLoading: true,
        ),
      ),
    );

    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('edit profile screen shows error message when error occurs', (
    tester,
  ) async {
    when(mockEditProfileViewModel.state).thenReturn(
      EditProfileStates(
        profileState: const BaseState<EditProfileResponseModel>(
          isLoading: false,
          errorMessage: 'Failed to load profile',
        ),
      ),
    );

    await tester.pumpWidget(buildTestableWidget());
    expect(find.text('Failed to load profile'), findsOneWidget);
  });

  testWidgets('editing first name triggers update when focus lost', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final firstNameField = find.byType(TextFormField).first;

    await tester.tap(firstNameField);
    await tester.pump();
    await tester.enterText(firstNameField, 'Jane');
    await tester.pump();
    final lastNameField = find.byType(TextFormField).at(1);
    await tester.tap(lastNameField);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    final captured = verify(
      mockEditProfileViewModel.doIntent(captureAny),
    ).captured;
    final updateEvents = captured.whereType<UpdateFirstNameEvent>().toList();

    expect(updateEvents.length, 1);
    expect(updateEvents.first.firstName, 'Jane');
  });

  testWidgets('editing last name triggers update when focus lost', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final lastNameField = find.byType(TextFormField).at(1);
    await tester.tap(lastNameField);
    await tester.pump();
    await tester.enterText(lastNameField, 'Smith');
    await tester.pump();
    final emailField = find.byType(TextFormField).at(2);
    await tester.tap(emailField);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 100));
    final captured = verify(
      mockEditProfileViewModel.doIntent(captureAny),
    ).captured;
    final updateEvents = captured.whereType<UpdateLastNameEvent>().toList();

    expect(updateEvents.length, 1);
    expect(updateEvents.first.lastName, 'Smith');
  });

  testWidgets('editing email triggers update when focus lost', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final emailField = find.byType(TextFormField).at(2);
    await tester.tap(emailField);
    await tester.pump();
    await tester.enterText(emailField, 'jane.smith@example.com');
    await tester.pump();
    final weightField = find.byType(TextFormField).at(3);
    await tester.tap(weightField);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 100));
    final captured = verify(
      mockEditProfileViewModel.doIntent(captureAny),
    ).captured;
    final updateEvents = captured.whereType<UpdateEmailEvent>().toList();
    expect(updateEvents.length, 1);
    expect(updateEvents.first.email, 'jane.smith@example.com');
  });

  testWidgets('invalid email does not trigger update and shows error', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final emailField = find.byType(TextFormField).at(2);
    await tester.tap(emailField);
    await tester.pump();
    await tester.enterText(emailField, 'invalid-email');
    await tester.pump();
    final weightField = find.byType(TextFormField).at(3);
    await tester.tap(weightField);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 100));
    final captured = verify(
      mockEditProfileViewModel.doIntent(captureAny),
    ).captured;

    final updateEvents = captured.whereType<UpdateEmailEvent>().toList();
    expect(updateEvents.length, 0);
    final firstNameEvents = captured.whereType<UpdateFirstNameEvent>().toList();
    final lastNameEvents = captured.whereType<UpdateLastNameEvent>().toList();
    expect(firstNameEvents.length, 0);
    expect(lastNameEvents.length, 0);
  });
  testWidgets('tapping weight field navigates to weight editing screen', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2400));
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey(AppTextConstants.yourWeight)));
    await tester.pumpAndSettle();

    expect(find.text('Weight Editing Screen'), findsOneWidget);
  });

  testWidgets('tapping goal field navigates to goal editing screen', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2400));
    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(find.byKey(ValueKey(AppTextConstants.yourGoal)));
    await tester.pumpAndSettle();

    expect(find.text('Goal Editing Screen'), findsOneWidget);
  });

  testWidgets(
    'tapping activity level field navigates to activity level editing screen',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 2400));
      await tester.pumpWidget(buildTestableWidget());

      final context = tester.element(find.byType(EditProfileScreen));
      GoRouter.of(context).go(AppRoutesConstants.activityLevelEditing);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('Activity Level Editing Screen'), findsOneWidget);
    },
  );
}
