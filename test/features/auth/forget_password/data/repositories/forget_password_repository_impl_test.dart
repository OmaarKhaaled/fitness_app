import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/api_exception.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/verify_code_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/repositories/forget_password_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ForgetPasswordRepositoryImpl repository;
  late MockForgetPasswordDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockForgetPasswordDataSource();
    repository = ForgetPasswordRepositoryImpl(mockDataSource);
  });

  group('forgetPassword', () {
    final request = ForgetPasswordRequestModel(email: 'test@test.com');
    final response = ForgetPasswordResponseModel(
      message: 'success',
      info: 'info',
    );

    test(
      'should return success BaseResponse when data source is successful',
      () async {
        when(
          mockDataSource.forgetPassword(request),
        ).thenAnswer((_) async => BaseResponse.success(response));

        final result = await repository.forgetPassword(request);

        verify(mockDataSource.forgetPassword(request)).called(1);
        expect(result.whenOrNull(success: (_) => true), true);
      },
    );

    test('should return failure BaseResponse when data source fails', () async {
      final exception = ApiException('Error');
      when(
        mockDataSource.forgetPassword(request),
      ).thenAnswer((_) async => BaseResponse.failure(exception));

      final result = await repository.forgetPassword(request);

      verify(mockDataSource.forgetPassword(request)).called(1);
      expect(result.whenOrNull(failure: (error) => error), exception);
    });
  });

  group('verifyCode', () {
    final request = VerifyCodeRequestModel(resetCode: '123456');
    final response = VerifyCodeResponseModel(status: 'success');

    test(
      'should return success BaseResponse when data source is successful',
      () async {
        when(
          mockDataSource.verifyCode(request),
        ).thenAnswer((_) async => BaseResponse.success(response));

        final result = await repository.verifyCode(request);

        verify(mockDataSource.verifyCode(request)).called(1);
        expect(result.whenOrNull(success: (_) => true), true);
      },
    );

    test('should return failure BaseResponse when data source fails', () async {
      final exception = ApiException('Error');
      when(
        mockDataSource.verifyCode(request),
      ).thenAnswer((_) async => BaseResponse.failure(exception));

      final result = await repository.verifyCode(request);

      verify(mockDataSource.verifyCode(request)).called(1);
      expect(result.whenOrNull(failure: (error) => error), exception);
    });
  });

  group('resetPassword', () {
    const request = ResetPasswordRequestModel(
      email: 'test@test.com',
      newPassword: 'password',
    );
    const response = ResetPasswordResponseModel(
      message: 'success',
      token: 'token',
    );

    test(
      'should return success BaseResponse when data source is successful',
      () async {
        when(
          mockDataSource.resetPassword(request),
        ).thenAnswer((_) async => const BaseResponse.success(response));

        final result = await repository.resetPassword(request);

        verify(mockDataSource.resetPassword(request)).called(1);
        expect(result.whenOrNull(success: (_) => true), true);
      },
    );

    test('should return failure BaseResponse when data source fails', () async {
      final exception = ApiException('Error');
      when(
        mockDataSource.resetPassword(request),
      ).thenAnswer((_) async => BaseResponse.failure(exception));

      final result = await repository.resetPassword(request);

      verify(mockDataSource.resetPassword(request)).called(1);
      expect(result.whenOrNull(failure: (error) => error), exception);
    });
  });
}
