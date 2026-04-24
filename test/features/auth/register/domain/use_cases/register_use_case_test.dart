import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/auth/register/data/repos/register_repo_impl.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_response_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/user_model.dart';
import 'package:fitness_app/features/auth/register/domain/use_cases/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([RegisterRepoImpl])
void main() {
  late RegisterUseCase registerUseCase;
  late MockRegisterRepoImpl mockRegisterRepoImpl;
  setUp(() {
    provideDummy<BaseResponse<RegisterResponseModel>>(
      BaseResponse.success(RegisterResponseModel()),
    );
    mockRegisterRepoImpl = MockRegisterRepoImpl();
    registerUseCase = RegisterUseCase(mockRegisterRepoImpl);
  });
  group('RegisterUseCase test cases', () {
    test('success case with success response', () async {
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
      when(mockRegisterRepoImpl.register(dummyRequest)).thenAnswer(
        (_) async => BaseResponse<RegisterResponseModel>.success(dummyRes),
      );
      final result = await registerUseCase.call(dummyRequest);
      expect(result, isA<BaseResponse<RegisterResponseModel>>());
      expect(
        result.mapOrNull(success: (value) => dummyRes.message),
        equals(dummyRes.message),
      );
      expect(
        result.mapOrNull(success: (value) => dummyRes.token),
        equals(dummyRes.token),
      );
      verify(mockRegisterRepoImpl.register(dummyRequest)).called(1);
    });
    test('failure case with failure response', () async {
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
      when(mockRegisterRepoImpl.register(dummyRequest)).thenAnswer(
        (_) async =>
            BaseResponse<RegisterResponseModel>.failure(dummyException),
      );
      final result = await registerUseCase.call(dummyRequest);
      expect(result, isA<BaseResponse<RegisterResponseModel>>());
      expect(
        result.mapOrNull(failure: (value) => dummyException.message),
        equals(dummyException.message),
      );
      verify(mockRegisterRepoImpl.register(dummyRequest)).called(1);
    });
  });
}
