import 'package:fitness_app/core/constants/app_routes_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/constants/validation_constants.dart';
import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_screen_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockRegisterViewModel;
  late GetIt getIt;
  setUp(() {
    mockRegisterViewModel = MockRegisterViewModel();
    getIt = GetIt.instance;
    if (getIt.isRegistered<RegisterViewModel>()) {
      getIt.unregister<RegisterViewModel>();
    }
    getIt.registerSingleton<RegisterViewModel>(mockRegisterViewModel);
    when(mockRegisterViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockRegisterViewModel.state).thenReturn(
      RegisterStates(
        registerationData: RegisterationDataModel(
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          rePassword: '',
        ),
      ),
    );
  });
  tearDown(() {
    if (getIt.isRegistered<RegisterViewModel>()) {
      getIt.unregister<RegisterViewModel>();
    }
  });
  Widget buildTestableWidget() {
    final testRouter = GoRouter(
      initialLocation: AppRoutesConstants.registerRoute,
      routes: [
        GoRoute(
          path: AppRoutesConstants.registerRoute,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: AppRoutesConstants.additionalRegisterInfoRoute,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Additional Info Screen')),
          ),
        ),
        GoRoute(
          path: AppRoutesConstants.loginRoute,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Login Screen'))),
        ),
      ],
    );
    return MaterialApp.router(routerConfig: testRouter);
  }

  Future<void> _validateFormAndTapButton(WidgetTester tester) async {
    // Get the form state and trigger validation
    final formState = tester.state<FormState>(find.byType(Form));
    formState.validate();
    await tester.pump();

    // Scroll to and tap button
    await tester.ensureVisible(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
  }
  testWidgets('register screen in initial state...', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    expect(find.byType(AppScaffold), findsOneWidget);
    expect(find.byType(BlurCard), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(11));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerGreeting), findsOneWidget);
    expect(find.text(AppTextConstants.registerCreateAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerHeading), findsOneWidget);
    expect(
      find.text(AppTextConstants.registerFirstNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerLastNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerEmailPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerPasswordPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerRePasswordPlaceholder),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.registerButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerAlreadyAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerLoginLink), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(7));
  });
  testWidgets(
    'error validation state when pressing the button with empty fields',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();
      await _validateFormAndTapButton(tester);
      // Now error messages should appear
      expect(find.text('This field is required'), findsNWidgets(2));
      expect(find.text(ValidationConstants.emailRequired), findsOneWidget);
      expect(find.text(ValidationConstants.passwordRequired), findsOneWidget);
      expect(
        find.text(ValidationConstants.confirmPasswordRequired),
        findsOneWidget,
      );
    },
  );
  testWidgets('error validation case with invalid email', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerFirstNamePlaceholder),
      'Islam',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerLastNamePlaceholder),
      'Ramzy',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerEmailPlaceholder),
      'IslamRamzy2',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerPasswordPlaceholder),
      'Solm@2020',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerRePasswordPlaceholder),
      'Solm@2020',
    );
    await _validateFormAndTapButton(tester);
    await tester.pump();
    expect(find.byType(AppScaffold), findsOneWidget);
    expect(find.byType(BlurCard), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(12));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerGreeting), findsOneWidget);
    expect(find.text(AppTextConstants.registerCreateAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerHeading), findsOneWidget);
    expect(
      find.text(AppTextConstants.registerFirstNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerLastNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerEmailPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerPasswordPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerRePasswordPlaceholder),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.registerButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerAlreadyAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerLoginLink), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(7));
    expect(find.text(ValidationConstants.invalidEmail), findsOneWidget);
  });
  testWidgets('error validation case with short password', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerFirstNamePlaceholder),
      'Islam',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerLastNamePlaceholder),
      'Ramzy',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerEmailPlaceholder),
      'islam@gmail.com',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerPasswordPlaceholder),
      'So@1',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerRePasswordPlaceholder),
      'So@1',
    );
    await _validateFormAndTapButton(tester);
    await tester.pump();
    expect(find.byType(AppScaffold), findsOneWidget);
    expect(find.byType(BlurCard), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(12));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerGreeting), findsOneWidget);
    expect(find.text(AppTextConstants.registerCreateAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerHeading), findsOneWidget);
    expect(
      find.text(AppTextConstants.registerFirstNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerLastNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerEmailPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerPasswordPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerRePasswordPlaceholder),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.registerButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerAlreadyAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerLoginLink), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(7));
    expect(find.text(ValidationConstants.passwordMinLength), findsOneWidget);
  });
  testWidgets('validation error case with password with no upper case', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerFirstNamePlaceholder),
      'Islam',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerLastNamePlaceholder),
      'Ramzy',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerEmailPlaceholder),
      'islam@gmail.com',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerPasswordPlaceholder),
      'solm@2020',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerRePasswordPlaceholder),
      'solm@2020',
    );
    await _validateFormAndTapButton(tester);
    await tester.pump();
    expect(find.byType(AppScaffold), findsOneWidget);
    expect(find.byType(BlurCard), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(12));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerGreeting), findsOneWidget);
    expect(find.text(AppTextConstants.registerCreateAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerHeading), findsOneWidget);
    expect(
      find.text(AppTextConstants.registerFirstNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerLastNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerEmailPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerPasswordPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerRePasswordPlaceholder),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.registerButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerAlreadyAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerLoginLink), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(7));
    expect(find.text(ValidationConstants.passwordUpperCase), findsOneWidget);
  });
  testWidgets('validation test case with password with no lower case', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerFirstNamePlaceholder),
      'Islam',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerLastNamePlaceholder),
      'Ramzy',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerEmailPlaceholder),
      'islam@gmail.com',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerPasswordPlaceholder),
      'SOLM@2020',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerRePasswordPlaceholder),
      'SOLM@2020',
    );
    await _validateFormAndTapButton(tester);
    await tester.pump();
    expect(find.byType(AppScaffold), findsOneWidget);
    expect(find.byType(BlurCard), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(12));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerGreeting), findsOneWidget);
    expect(find.text(AppTextConstants.registerCreateAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerHeading), findsOneWidget);
    expect(
      find.text(AppTextConstants.registerFirstNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerLastNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerEmailPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerPasswordPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerRePasswordPlaceholder),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.registerButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerAlreadyAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerLoginLink), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(7));
    expect(find.text(ValidationConstants.passwordLowerCase), findsOneWidget);
  });
  testWidgets('validation test case with password with no numbers', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerFirstNamePlaceholder),
      'Islam',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerLastNamePlaceholder),
      'Ramzy',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerEmailPlaceholder),
      'islam@gmail.com',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerPasswordPlaceholder),
      'Solm@elba',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerRePasswordPlaceholder),
      'Solm@elba',
    );
    await _validateFormAndTapButton(tester);
    await tester.pump();
    expect(find.byType(AppScaffold), findsOneWidget);
    expect(find.byType(BlurCard), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(12));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerGreeting), findsOneWidget);
    expect(find.text(AppTextConstants.registerCreateAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerHeading), findsOneWidget);
    expect(
      find.text(AppTextConstants.registerFirstNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerLastNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerEmailPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerPasswordPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerRePasswordPlaceholder),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.registerButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerAlreadyAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerLoginLink), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(7));
    expect(find.text(ValidationConstants.passwordNumber), findsOneWidget);
  });
  testWidgets('validation test case with password with no special char', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerFirstNamePlaceholder),
      'Islam',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerLastNamePlaceholder),
      'Ramzy',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerEmailPlaceholder),
      'islam@gmail.com',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerPasswordPlaceholder),
      'Solm2020',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerRePasswordPlaceholder),
      'Solm2020',
    );
    await _validateFormAndTapButton(tester);
    await tester.pump();
    expect(find.byType(AppScaffold), findsOneWidget);
    expect(find.byType(BlurCard), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(12));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerGreeting), findsOneWidget);
    expect(find.text(AppTextConstants.registerCreateAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerHeading), findsOneWidget);
    expect(
      find.text(AppTextConstants.registerFirstNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerLastNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerEmailPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerPasswordPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerRePasswordPlaceholder),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.registerButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerAlreadyAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerLoginLink), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(7));
    expect(find.text(ValidationConstants.passwordSpecialChar), findsOneWidget);
  });
  testWidgets('validation test case with password with mismatched passwords', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerFirstNamePlaceholder),
      'Islam',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerLastNamePlaceholder),
      'Ramzy',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerEmailPlaceholder),
      'islam@gmail.com',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerPasswordPlaceholder),
      'Solm@2020',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerRePasswordPlaceholder),
      'Solm@2021',
    );
    await _validateFormAndTapButton(tester);
    await tester.pump();
    expect(find.byType(AppScaffold), findsOneWidget);
    expect(find.byType(BlurCard), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(Text), findsNWidgets(12));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerGreeting), findsOneWidget);
    expect(find.text(AppTextConstants.registerCreateAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerHeading), findsOneWidget);
    expect(
      find.text(AppTextConstants.registerFirstNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerLastNamePlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerEmailPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerPasswordPlaceholder),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.registerRePasswordPlaceholder),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.registerButton), findsOneWidget);
    expect(find.text(AppTextConstants.registerAlreadyAccount), findsOneWidget);
    expect(find.text(AppTextConstants.registerLoginLink), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(IconButton), findsNWidgets(2));
    expect(find.byType(Icon), findsNWidgets(7));
    expect(find.text(ValidationConstants.passwordsDoNotMatch), findsOneWidget);
  });
  testWidgets(
  'success validation case - navigates to additional info screen when all fields are valid',
  (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));
    
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerFirstNamePlaceholder),
      'Islam',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerLastNamePlaceholder),
      'Ramzy',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerEmailPlaceholder),
      'islam@gmail.com',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerPasswordPlaceholder),
      'Solm@2020',
    );
    await tester.enterText(
      find.bySemanticsLabel(AppTextConstants.registerRePasswordPlaceholder),
      'Solm@2020',
    );

    await tester.pumpAndSettle();
    
    // Manually trigger the button's onPressed
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    button.onPressed?.call();
    await tester.pumpAndSettle();
    
    // Verify the intent was called with the correct data
    final captured = verify(mockRegisterViewModel.doIntent(captureAny)).captured;
    expect(captured.length, 1);
    expect(captured.first, isA<CacheRegistrationDataEvent>());
    
    final event = captured.first as CacheRegistrationDataEvent;
    expect(event.data.firstName, 'Islam');
    expect(event.data.email, 'islam@gmail.com');
  },
);
}
