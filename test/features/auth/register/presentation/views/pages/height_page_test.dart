import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/pages/height_page.dart';
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
        selectedHeight: 165,
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
        home: Scaffold(body: HeightPage(pageController: pageController)),
      ),
    );
  }

  testWidgets('HeightPage renders all UI elements correctly', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(
      find.text(AppTextConstants.profileSetupHeightQuestion),
      findsOneWidget,
    );
    expect(
      find.text(AppTextConstants.profileSetupHeightSelectionInfo),
      findsOneWidget,
    );
    expect(find.text(AppTextConstants.profileSetupHeightUnit), findsOneWidget);
    expect(
      find.text(AppTextConstants.profileSetupHeightButton),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.arrow_drop_up), findsOneWidget);
  });

  testWidgets('HeightPage shows default height 165', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 2400));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.text('165'), findsOneWidget);
  });

  testWidgets('HeightPage changes height when scrolling to a different value', (
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

  testWidgets('HeightPage arrow up button increases height', (tester) async {
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
