import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/activity_level_page.dart';
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
  late GetIt getIt;

  setUpAll(() {
    // Ensure test binding is initialized
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockViewModel = MockRegisterViewModel();
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
        selectedActivityLevel: null,
      ),
    );
  });

  tearDown(() {
    if (getIt.isRegistered<RegisterViewModel>()) {
      getIt.unregister<RegisterViewModel>();
    }
  });

  Widget buildTestableWidget() {
    return BlocProvider<RegisterViewModel>.value(
      value: mockViewModel,
      child: MaterialApp(
        home: Scaffold(body: ActivityLevelPage(onTap: () {})),
      ),
    );
  }

  testWidgets('ActivityLevelPage renders all UI elements correctly', (
    tester,
  ) async {
    // Set a larger screen size to prevent overflow
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(
      find.text(AppTextConstants.profileSetupActivityQuestion),
      findsOneWidget,
    );
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
    expect(
      find.text(AppTextConstants.profileSetupActivityButton),
      findsOneWidget,
    );
  });

  testWidgets('ActivityLevelPage button is disabled when no level selected', (
    tester,
  ) async {
    // Set a larger screen size to prevent overflow
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(
        ElevatedButton,
        AppTextConstants.profileSetupActivityButton,
      ),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('ActivityLevelPage button is enabled when level is selected', (
    tester,
  ) async {
    // Set a larger screen size to prevent overflow
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    when(mockViewModel.state).thenReturn(
      RegisterStates(
        registerationData: RegisterationDataModel(
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          rePassword: '',
        ),
        selectedActivityLevel: 'level1',
      ),
    );

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(
        ElevatedButton,
        AppTextConstants.profileSetupActivityButton,
      ),
    );
    expect(button.onPressed, isNotNull);
  });
}
