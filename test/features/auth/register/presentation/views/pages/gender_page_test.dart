import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/gender_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'gender_page_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;
  late PageController pageController;
  late GetIt getIt;
  setUp(() {
    mockViewModel = MockRegisterViewModel();
    pageController = PageController();
    getIt = GetIt.instance;
    if (getIt.isRegistered<RegisterViewModel>()) {
      getIt.unregister<RegisterViewModel>();
    }
    getIt.registerSingleton<RegisterViewModel>(mockViewModel);
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(mockViewModel.state).thenReturn(
      RegisterStates(
        registerationData: RegisterationDataModel(
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          rePassword: '',
        ),
        selectedGender: null,
      ),
    );
  });

  tearDown(() {
    if (getIt.isRegistered<RegisterViewModel>()) {
      getIt.unregister<RegisterViewModel>();
    }
    pageController.dispose();
  });

  Widget buildTestableWidget() {
    return BlocProvider<RegisterViewModel>.value(
      value: mockViewModel,
      child: MaterialApp(
        home: Scaffold(body: GenderPage(pageController: pageController)),
      ),
    );
  }

  testWidgets('GenderPage renders all UI elements correctly', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text(AppTextConstants.profileSetupTellUs), findsOneWidget);
    expect(
      find.text(AppTextConstants.profileSetupGenderSelectInstruction),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.profileSetupGenderMale), findsOneWidget);
    expect(
      find.text(AppTextConstants.profileSetupGenderFemale),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.profileSetupGenderButton),
      findsOneWidget,
    );
  });

  testWidgets('GenderPage button is disabled when no gender selected', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(
        ElevatedButton,
        AppTextConstants.profileSetupGenderButton,
      ),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('GenderPage button is enabled when gender is selected', (
    tester,
  ) async {
    when(mockViewModel.state).thenReturn(
      RegisterStates(
        registerationData: RegisterationDataModel(
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          rePassword: '',
        ),
        selectedGender: 'male',
      ),
    );

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(
        ElevatedButton,
        AppTextConstants.profileSetupGenderButton,
      ),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Tapping male calls SelectGenderEvent', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppTextConstants.profileSetupGenderMale));
    await tester.pump();

    verify(mockViewModel.doIntent(any)).called(1);
  });

  testWidgets('Tapping female calls SelectGenderEvent', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppTextConstants.profileSetupGenderFemale));
    await tester.pump();

    verify(mockViewModel.doIntent(any)).called(1);
  });
}
