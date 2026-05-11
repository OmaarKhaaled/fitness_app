import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_response_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/user_model.dart';
import 'package:fitness_app/features/auth/register/domain/use_cases/register_use_case.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_events.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_states.dart';
import 'package:fitness_app/features/auth/register/presentation/view_models/register_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_view_model_test.mocks.dart';

@GenerateMocks([RegisterUseCase])
void main() {
  late RegisterViewModel registerViewModel;
  late MockRegisterUseCase mockRegisterUseCase;
  setUp(() {
    provideDummy<BaseResponse<RegisterResponseModel>>(
      BaseResponse<RegisterResponseModel>.success(RegisterResponseModel()),
    );
    mockRegisterUseCase = MockRegisterUseCase();
    registerViewModel = RegisterViewModel(mockRegisterUseCase);
  });
  tearDownAll(() {
    registerViewModel.close();
  });
  group('RegisterEvent cases', () {
    test('success case with success response', () {
      final dummyRequest = RegisterRequestModel(
        email: 'test1@email.com',
        firstName: 'Islam',
        lastName: 'Elba',
        gender: 'male',
        age: 33,
        weight: 100,
        height: 178,
        goal: 'Lose Weight',
        activityLevel: 'level1',
      );
      final dummyRes = RegisterResponseModel(
        message: 'success',
        token: 'dummy_token',
        user: UserModel(),
      );
      when(mockRegisterUseCase.call(dummyRequest)).thenAnswer(
        (_) async => BaseResponse<RegisterResponseModel>.success(dummyRes),
      );
      expectLater(
        registerViewModel.stream,
        emitsInOrder([
          predicate<RegisterStates>(
            (state) => state.registerState?.isLoading == true,
          ),
          predicate<RegisterStates>(
            (state) =>
                state.registerState?.isLoading == false &&
                state.registerState?.data == dummyRes,
          ),
        ]),
      );
      registerViewModel.doIntent(RegisterEvent(dummyRequest));
    });
    test('error case with error response(failure response)', () {
      final dummyRequest = RegisterRequestModel(
        email: 'test1@email.com',
        firstName: 'Islam',
        lastName: 'Elba',
        gender: 'male',
        age: 33,
        weight: 100,
        height: 178,
        goal: 'Lose Weight',
        activityLevel: 'level1',
      );
      final dummyException = ExceptionsHandler.handle(
        Exception('Network Error'),
      );
      when(mockRegisterUseCase.call(dummyRequest)).thenAnswer(
        (_) async =>
            BaseResponse<RegisterResponseModel>.failure(dummyException),
      );
      expectLater(
        registerViewModel.stream,
        emitsInOrder([
          predicate<RegisterStates>(
            (state) => state.registerState?.isLoading == true,
          ),
          predicate<RegisterStates>(
            (state) =>
                state.registerState?.isLoading == false &&
                state.registerState?.errorMessage == dummyException.message,
          ),
        ]),
      );
      registerViewModel.doIntent(RegisterEvent(dummyRequest));
    });
  });
  test('TogglePasswordHiddenEvent toggles password visibility', () {
    expect(registerViewModel.state.isPasswordHidden, true);
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>((state) => state.isPasswordHidden == false),
      ]),
    );
    registerViewModel.doIntent(TogglePasswordHiddenEvent());
  });
  test('ToggleRePasswordHiddenEvent toggles rePassword visibility', () {
    expect(registerViewModel.state.isRePasswordHidden, true);
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>((state) => state.isRePasswordHidden == false),
      ]),
    );
    registerViewModel.doIntent(ToggleRePasswordHiddenEvent());
  });
  test('UpdateRegistrationDataEvent updates registration data', () {
    final updatedData = RegisterationDataModel(
      firstName: 'Ahmed',
      lastName: 'Mohamed',
      email: 'ahmed@test.com',
      password: 'password123',
      rePassword: 'password123',
    );
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>(
          (state) =>
              state.registerationData.firstName == 'Ahmed' &&
              state.registerationData.lastName == 'Mohamed' &&
              state.registerationData.email == 'ahmed@test.com',
        ),
      ]),
    );
    registerViewModel.doIntent(UpdateRegistrationDataEvent(updatedData));
  });
  test('NextPageEvent increments page index (not exceeding 5)', () {
    expect(registerViewModel.state.currentPageIndex, 0);
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>((state) => state.currentPageIndex == 1),
      ]),
    );
    registerViewModel.doIntent(NextPageEvent());
    for (int i = 1; i < 5; i++) {
      registerViewModel.doIntent(NextPageEvent());
    }
    expect(registerViewModel.state.currentPageIndex, 5);
    registerViewModel.doIntent(NextPageEvent());
    expect(registerViewModel.state.currentPageIndex, 5);
  });
  test('PreviousPageEvent decrements page index (not below 0)', () {
    for (int i = 0; i < 3; i++) {
      registerViewModel.doIntent(NextPageEvent());
    }
    expect(registerViewModel.state.currentPageIndex, 3);
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>((state) => state.currentPageIndex == 2),
      ]),
    );
    registerViewModel.doIntent(PreviousPageEvent());
    for (int i = 0; i < 3; i++) {
      registerViewModel.doIntent(PreviousPageEvent());
    }
    expect(registerViewModel.state.currentPageIndex, 0);
  });
  test('SubmitRegistrationEvent triggers registration with current data', () {
    final registrationData = RegisterationDataModel(
      firstName: 'Islam',
      lastName: 'Elba',
      email: 'islam@test.com',
      password: 'password123',
      rePassword: 'password123',
      gender: 'male',
      age: 33,
      weight: 100,
      height: 178,
      goal: 'Lose Weight',
      activityLevel: 'level1',
    );
    registerViewModel.doIntent(UpdateRegistrationDataEvent(registrationData));
    registrationData.toRegisterRequest();
    final dummyRes = RegisterResponseModel(
      message: 'success',
      token: 'dummy_token',
      user: UserModel(),
    );
    when(mockRegisterUseCase.call(any)).thenAnswer(
      (_) async => BaseResponse<RegisterResponseModel>.success(dummyRes),
    );
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>(
          (state) => state.registerState?.isLoading == true,
        ),
        predicate<RegisterStates>(
          (state) =>
              state.registerState?.isLoading == false &&
              state.registerState?.data == dummyRes,
        ),
      ]),
    );
    registerViewModel.doIntent(SubmitRegistrationEvent());
  });
  test('SelectGenderEvent updates gender and registration data', () {
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>((state) => state.selectedGender == 'male'),
        predicate<RegisterStates>(
          (state) => state.registerationData.gender == 'male',
        ),
      ]),
    );
    registerViewModel.doIntent(SelectGenderEvent('male'));
  });
  test(
    'CacheRegistrationDataEvent caches data and updates registration data',
    () {
      final cachedData = RegisterationDataModel(
        firstName: 'Cached',
        lastName: 'User',
        email: 'cached@test.com',
        password: 'pass',
        rePassword: 'pass',
      );
      expectLater(
        registerViewModel.stream,
        emitsInOrder([
          predicate<RegisterStates>(
            (state) =>
                state.cachedRegistrationData?.firstName == 'Cached' &&
                state.registerationData.firstName == 'Cached',
          ),
        ]),
      );
      registerViewModel.doIntent(CacheRegistrationDataEvent(cachedData));
    },
  );
  test('SelectAgeEvent updates age and registration data', () {
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>((state) => state.selectedAge == 30),
        predicate<RegisterStates>((state) => state.registerationData.age == 30),
      ]),
    );
    registerViewModel.doIntent(SelectAgeEvent(30));
  });
  test('SelectWeightEvent updates weight and registration data', () {
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>((state) => state.selectedWeight == 75),
        predicate<RegisterStates>(
          (state) => state.registerationData.weight == 75,
        ),
      ]),
    );
    registerViewModel.doIntent(SelectWeightEvent(75));
  });
  test('SelectHeightEvent updates height and registration data', () {
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>((state) => state.selectedHeight == 180),
        predicate<RegisterStates>(
          (state) => state.registerationData.height == 180,
        ),
      ]),
    );
    registerViewModel.doIntent(SelectHeightEvent(180));
  });
  test('SelectGoalEvent updates goal and registration data', () {
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>(
          (state) => state.selectedGoal == 'Gain Weight',
        ),
        predicate<RegisterStates>(
          (state) => state.registerationData.goal == 'Gain Weight',
        ),
      ]),
    );
    registerViewModel.doIntent(SelectGoalEvent('Gain Weight'));
  });
  test(
    'SelectActivityLevelEvent updates activity level and registration data',
    () {
      expectLater(
        registerViewModel.stream,
        emitsInOrder([
          predicate<RegisterStates>(
            (state) => state.selectedActivityLevel == 'level3',
          ),
          predicate<RegisterStates>(
            (state) => state.registerationData.activityLevel == 'level3',
          ),
        ]),
      );
      registerViewModel.doIntent(SelectActivityLevelEvent('level3'));
    },
  );
  group('Multiple events sequence tests', () {
    test('Complete registration flow updates state correctly', () {
      registerViewModel.doIntent(SelectGenderEvent('female'));
      registerViewModel.doIntent(SelectAgeEvent(28));
      registerViewModel.doIntent(SelectWeightEvent(65));
      registerViewModel.doIntent(SelectHeightEvent(165));
      registerViewModel.doIntent(SelectGoalEvent('Maintain Weight'));
      registerViewModel.doIntent(SelectActivityLevelEvent('level2'));
      final finalState = registerViewModel.state;
      expect(finalState.selectedGender, 'female');
      expect(finalState.selectedAge, 28);
      expect(finalState.selectedWeight, 65);
      expect(finalState.selectedHeight, 165);
      expect(finalState.selectedGoal, 'Maintain Weight');
      expect(finalState.selectedActivityLevel, 'level2');
      expect(finalState.registerationData.gender, 'female');
      expect(finalState.registerationData.age, 28);
      expect(finalState.registerationData.weight, 65);
      expect(finalState.registerationData.height, 165);
      expect(finalState.registerationData.goal, 'Maintain Weight');
      expect(finalState.registerationData.activityLevel, 'level2');
    });

    test('Page navigation flow maintains correct state', () {
      registerViewModel.doIntent(NextPageEvent());
      expect(registerViewModel.state.currentPageIndex, 1);
      registerViewModel.doIntent(PreviousPageEvent());
      expect(registerViewModel.state.currentPageIndex, 0);
      registerViewModel.doIntent(SelectGenderEvent('male'));
      registerViewModel.doIntent(NextPageEvent());
      expect(registerViewModel.state.currentPageIndex, 1);
      expect(registerViewModel.state.selectedGender, 'male');
    });
  });
  test('ClearCachedDataEvent clears all cached data and resets state', () {
    final testData = RegisterationDataModel(
      firstName: 'Test',
      lastName: 'User',
      email: 'test@email.com',
      password: 'password123',
      rePassword: 'password123',
    );
    registerViewModel.doIntent(SelectGenderEvent('male'));
    registerViewModel.doIntent(SelectAgeEvent(30));
    registerViewModel.doIntent(SelectWeightEvent(80));
    registerViewModel.doIntent(CacheRegistrationDataEvent(testData));
    expect(registerViewModel.state.selectedGender, 'male');
    expect(registerViewModel.state.selectedAge, 30);
    expect(registerViewModel.state.cachedRegistrationData?.firstName, 'Test');

    // Clear all cached data
    expectLater(
      registerViewModel.stream,
      emitsInOrder([
        predicate<RegisterStates>(
          (state) =>
              state.registerationData.firstName == '' &&
              state.registerationData.lastName == '' &&
              state.registerationData.email == '' &&
              state.registerationData.password == '' &&
              state.registerationData.rePassword == '' &&
              state.selectedGender == null &&
              state.selectedAge == 25 &&
              state.selectedWeight == 90 &&
              state.selectedHeight == 165 &&
              state.selectedGoal == null &&
              state.selectedActivityLevel == null &&
              state.cachedRegistrationData == null &&
              state.currentPageIndex == 0 &&
              state.isRegistrationComplete == false,
        ),
      ]),
    );

    registerViewModel.doIntent(ClearCachedDataEvent());
  });
  test(
    'ClearCachedDataEvent prevents stale data from being reloaded after clear',
    () {
      final testData = RegisterationDataModel(
        firstName: 'Stale',
        lastName: 'Data',
        email: 'stale@email.com',
        password: 'pass123',
        rePassword: 'pass123',
      );

      registerViewModel.doIntent(CacheRegistrationDataEvent(testData));
      expect(
        registerViewModel.state.cachedRegistrationData?.firstName,
        'Stale',
      );

      registerViewModel.doIntent(ClearCachedDataEvent());
      expect(registerViewModel.state.cachedRegistrationData, null);
      expect(registerViewModel.state.registerationData.firstName, '');
      final newData = RegisterationDataModel(
        firstName: 'Fresh',
        lastName: 'Start',
        email: 'fresh@email.com',
        password: 'newpass123',
        rePassword: 'newpass123',
      );

      registerViewModel.doIntent(CacheRegistrationDataEvent(newData));
      expect(
        registerViewModel.state.cachedRegistrationData?.firstName,
        'Fresh',
      );
      expect(registerViewModel.state.registerationData.firstName, 'Fresh');
    },
  );
}
