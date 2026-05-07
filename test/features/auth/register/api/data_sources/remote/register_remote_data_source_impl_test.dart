import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/api/api_client/register_api_client.dart';
import 'package:fitness_app/features/auth/register/api/data_sources/remote/register_remote_data_source_impl.dart';
import 'package:fitness_app/features/auth/register/data/models/register_request_dto.dart';
import 'package:fitness_app/features/auth/register/data/models/register_response.dart';
import 'package:fitness_app/features/auth/register/data/models/user_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([RegisterApiClient])
void main() {
  late RegisterRemoteDataSourceImpl registerRemoteDataSourceImpl;
  late MockRegisterApiClient mockRegisterApiClient;
  setUp(() {
    mockRegisterApiClient = MockRegisterApiClient();
    registerRemoteDataSourceImpl = RegisterRemoteDataSourceImpl(
      mockRegisterApiClient,
    );
  });
  test('testing the functionality of register function', () async {
    final dummyRequest = RegisterRequestDto(
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
    when(
      mockRegisterApiClient.register(dummyRequest),
    ).thenAnswer((_) async => dummyRes);
    final result = await registerRemoteDataSourceImpl.register(dummyRequest);
    expect(result, isA<BaseResponse<RegisterResponse>>());
    expect(result, BaseResponse<RegisterResponse>.success(dummyRes));
    expect(
      result.mapOrNull(success: (value) => value.data.message),
      equals(dummyRes.message),
    );
    expect(
      result.mapOrNull(success: (value) => value.data.token),
      equals(dummyRes.token),
    );
    verify(mockRegisterApiClient.register(dummyRequest)).called(1);
  });
}
