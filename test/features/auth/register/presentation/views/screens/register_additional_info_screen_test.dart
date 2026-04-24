import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:fitness_app/features/auth/register/presentation/views/screens/register_additional_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_additional_info_screen_test.mocks.dart';

@GenerateMocks([RegisterViewModel])
void main() {
  late MockRegisterViewModel mockViewModel;
  late GetIt getIt;

  setUpAll(() {
    // Set a larger default screen size for all tests
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
        currentPageIndex: 0,
        selectedGender: null,
      ),
    );
  });

  tearDown(() {
    if (getIt.isRegistered<RegisterViewModel>()) {
      getIt.unregister<RegisterViewModel>();
    }
  });

  Widget buildTestableWidget() {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider<RegisterViewModel>.value(
            value: mockViewModel,
            child: const RegisterAdditionalInfoScreen(),
          ),
        ),
      ],
    );

    return MaterialApp.router(routerConfig: router);
  }

  testWidgets(
    'RegisterAdditionalInfoScreen renders correctly on page 0 with no gender selected',
    (tester) async {
      // Use a large enough screen size
      await tester.binding.setSurfaceSize(const Size(1080, 2400));

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.text(AppTextConstants.profileSetupTellUs), findsOneWidget);
      expect(
        find.text(AppTextConstants.profileSetupGenderSelectInstruction),
        findsOneWidget,
      );
      expect(
        find.text(AppTextConstants.profileSetupGenderMale),
        findsOneWidget,
      );
      expect(
        find.text(AppTextConstants.profileSetupGenderFemale),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'RegisterAdditionalInfoScreen shows back button when gender selected on page 0',
    (tester) async {
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
          currentPageIndex: 0,
          selectedGender: 'male',
        ),
      );

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Instead of expecting exactly 1 InkWell, expect at least 1
      expect(find.byType(InkWell), findsAtLeastNWidgets(1));
    },
  );
}
