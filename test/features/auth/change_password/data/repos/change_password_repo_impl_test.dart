import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/features/auth/change_password/data/data_sources/change_pass_remote_datasources.dart';
import 'package:fitness_app/features/auth/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/auth/change_password/data/models/response/change_password_response.dart';
import 'package:fitness_app/features/auth/change_password/data/repos/change_password_repo_impl.dart';
import 'package:fitness_app/features/auth/change_password/domain/models/change_password_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_repo_impl_test.mocks.dart';

@GenerateMocks([ChangePasswordRemoteDataSource])
void main() {
  late MockChangePasswordRemoteDataSource dataSource;
  late ChangePasswordRepoImpl changePasswordRepoImpl;

  setUpAll(() {
    dataSource = MockChangePasswordRemoteDataSource();
    changePasswordRepoImpl = ChangePasswordRepoImpl(dataSource);
  });
  group('change password repo impl', () {
    final changePasswordRequest = ChangePasswordRequest(
      password: '123',
      newPassword: '12345',
    );

    test('return success model when data source returns success', () async {
      final fakeResponse = ChangePasswordResponse(
        message: 'success',
        token: 'abc123',
      );

      when(
        dataSource.changePassword(any),
      ).thenAnswer((_) async => BaseResponse.success(fakeResponse));

      final result = await changePasswordRepoImpl.changePassword(
        changePasswordRequest,
      );

      expect(result, isA<BaseSuccess<ChangePasswordModel>>());
      final data = (result as BaseSuccess<ChangePasswordModel>).data;
      expect(data.message, 'success');
      expect(data.token, 'abc123');

      verify(dataSource.changePassword(any)).called(1);
    });

    test('return failure when data source returns failure', () async {
      const exception = AppException('error');
      when(
        dataSource.changePassword(any),
      ).thenAnswer((_) async => const BaseResponse.failure(exception));

      final result = await changePasswordRepoImpl.changePassword(
        changePasswordRequest,
      );

      expect(result, isA<BaseFailure<ChangePasswordModel>>());
      verify(dataSource.changePassword(any)).called(1);
    });
  });
}
