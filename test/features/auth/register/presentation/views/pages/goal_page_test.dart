import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/goal_page.dart';
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

  setUpAll(() {
    // Ensure test binding is initialized
    TestWidgetsFlutterBinding.ensureInitialized();
  });

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
        selectedGoal: null,
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
        home: Scaffold(body: GoalPage(pageController: pageController)),
      ),
    );
  }

  testWidgets('GoalPage renders all UI elements correctly', (tester) async {
    // Set a larger screen size to prevent overflow
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(
      find.text(AppTextConstants.profileSetupGoalQuestion),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.profileSetupGoalSelectionInfo),
      findsOneWidget,
    );
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
    expect(find.text(AppTextConstants.profileSetupGoalButton), findsOneWidget);
  });

  testWidgets('GoalPage button is disabled when no goal selected', (
    tester,
  ) async {
    // Set a larger screen size to prevent overflow
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(
        ElevatedButton,
        AppTextConstants.profileSetupGoalButton,
      ),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('GoalPage button is enabled when goal is selected', (
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
        selectedGoal: 'Lose Weight',
      ),
    );

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(
        ElevatedButton,
        AppTextConstants.profileSetupGoalButton,
      ),
    );
    expect(button.onPressed, isNotNull);
  });
}
