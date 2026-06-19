import 'package:dio/dio.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/api_manager/api_client.dart';
import 'package:fitness_app/features/auth/change_password/api/change_pass_remote_datasources_impl.dart';
import 'package:fitness_app/features/auth/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/auth/change_password/data/models/response/change_password_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../api/aurh_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late ChangePassRemoteDatasourcesImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ChangePassRemoteDatasourcesImpl(apiClient: mockApiClient);
  });

  final changePasswordRequest = ChangePasswordRequest(
    password: '123',
    newPassword: '12345',
  );

  group('ChangePasswordRemoteDataSourceImpl', () {
    test(
      'returns BaseResponse.success when ApiClient returns valid response',
      () async {
        // arrange
        final fakeResponse = ChangePasswordResponse(
          message: 'success',
          token: 'abc123',
        );

        when(
          mockApiClient.changePassword(request: anyNamed('request')),
        ).thenAnswer((_) async => fakeResponse);

        // act
        final result = await dataSource.changePassword(changePasswordRequest);

        // assert
        expect(result, isA<BaseSuccess<ChangePasswordResponse>>());
        final data = (result as BaseSuccess<ChangePasswordResponse>).data;
        expect(data, fakeResponse);

        verify(
          mockApiClient.changePassword(request: anyNamed('request')),
        ).called(1);
      },
    );
  });

  group('ChangePasswordRemoteDataSourceImpl.changePassword', () {
    test('return error when API client throw error', () async {
      when(
        mockApiClient.changePassword(request: anyNamed('request')),
      ).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/change_password')),
      );

      final result = await dataSource.changePassword(changePasswordRequest);
      expect(result, isA<BaseFailure<ChangePasswordResponse>>());
      verify(
        mockApiClient.changePassword(request: anyNamed('request')),
      ).called(1);
    });
  });
}
