import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/age_page.dart';
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
        selectedAge: 25,
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
        home: Scaffold(body: AgePage(pageController: pageController)),
      ),
    );
  }

  testWidgets('AgePage renders all UI elements correctly', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.text(AppTextConstants.profileSetupAgeQuestion), findsOneWidget);
    expect(
      find.text(AppTextConstants.profileSetupAgeSelectionInfo),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.profileSetupAgeYear), findsOneWidget);
    expect(find.text(AppTextConstants.profileSetupAgeButton), findsOneWidget);
    expect(find.byIcon(Icons.arrow_drop_up), findsOneWidget);
  });

  testWidgets('AgePage shows default age 25', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.text('25'), findsOneWidget);
  });

  testWidgets('AgePage changes age when scrolling to a different value', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    final pageViewFinder = find.byType(PageView);
    expect(pageViewFinder, findsOneWidget);

    await tester.drag(pageViewFinder, const Offset(-300, 0));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    verify(mockViewModel.doIntent(any)).called(1);
  });

  testWidgets('AgePage arrow up button increases age', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    final upArrow = find.byIcon(Icons.arrow_drop_up);
    expect(upArrow, findsOneWidget);

    await tester.tap(upArrow);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    verify(mockViewModel.doIntent(any)).called(1);
  });
}
