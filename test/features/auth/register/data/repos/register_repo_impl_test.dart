import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/auth/register/api/data_sources/remote/register_remote_data_source_impl.dart';
import 'package:fitness_app/features/auth/register/data/models/register_response.dart';
import 'package:fitness_app/features/auth/register/data/models/user_dto.dart';
import 'package:fitness_app/features/auth/register/data/repos/register_repo_impl.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_repo_impl_test.mocks.dart';

@GenerateMocks([RegisterRemoteDataSourceImpl])
void main() {
  late RegisterRepoImpl registerRepoImpl;
  late MockRegisterRemoteDataSourceImpl mockRegisterRemoteDataSourceImpl;
  setUpAll(() {
    provideDummy<BaseResponse<RegisterResponse>>(
      BaseResponse.success(RegisterResponse()),
    );
    mockRegisterRemoteDataSourceImpl = MockRegisterRemoteDataSourceImpl();
    registerRepoImpl = RegisterRepoImpl(mockRegisterRemoteDataSourceImpl);
  });
  group('RegisterRepoImpl test cases', () {
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
      final dummyRes = RegisterResponse(
        message: 'success',
        token: 'dummy_token',
        user: UserDTO(),
      );
      when(mockRegisterRemoteDataSourceImpl.register(any)).thenAnswer(
        (_) async => BaseResponse<RegisterResponse>.success(dummyRes),
      );
      final result = await registerRepoImpl.register(dummyRequest);
      expect(result, isA<BaseResponse<RegisterResponseModel>>());
      expect(
        result.mapOrNull(success: (value) => value.data.message),
        equals(dummyRes.message),
      );
      expect(
        result.mapOrNull(success: (value) => value.data.token),
        equals(dummyRes.token),
      );
      verify(mockRegisterRemoteDataSourceImpl.register(any)).called(1);
    });
    test('error case with error response(failure response)', () async {
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
      when(mockRegisterRemoteDataSourceImpl.register(any)).thenAnswer(
        (_) async => BaseResponse<RegisterResponse>.failure(dummyException),
      );
      final result = await registerRepoImpl.register(dummyRequest);
      expect(result, isA<BaseResponse<RegisterResponseModel>>());
      expect(
        result.mapOrNull(failure: (value) => value.exception.message),
        equals(dummyException.message),
      );
      verify(mockRegisterRemoteDataSourceImpl.register(any)).called(1);
    });
  });
}
