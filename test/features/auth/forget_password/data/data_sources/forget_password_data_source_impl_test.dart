import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/forget_password/api/data_sources/forget_password_data_source_impl.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/verify_code_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ForgetPasswordDataSourceImpl dataSource;
  late MockForgetPasswordApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockForgetPasswordApiClient();
    dataSource = ForgetPasswordDataSourceImpl(mockApiClient);
  });

  group('forgetPassword', () {
    test(
      'should return success BaseResponse when API call is successful',
      () async {
        final request = ForgetPasswordRequestModel(email: 'test@test.com');
        final response = ForgetPasswordResponseModel(
          message: 'success',
          info: 'info',
        );
        when(
          mockApiClient.forgetPassword(request),
        ).thenAnswer((_) async => response);

        final result = await dataSource.forgetPassword(request);

        verify(mockApiClient.forgetPassword(request)).called(1);
        expect(result.whenOrNull(success: (data) => data), response);
      },
    );

    test('should return failure BaseResponse when API call fails', () async {
      final request = ForgetPasswordRequestModel(email: 'test@test.com');
      when(mockApiClient.forgetPassword(request)).thenThrow(Exception());

      final result = await dataSource.forgetPassword(request);

      verify(mockApiClient.forgetPassword(request)).called(1);
      expect(result.whenOrNull(failure: (error) => error), isNotNull);
    });
  });

  group('verifyCode', () {
    test(
      'should return success BaseResponse when API call is successful',
      () async {
        final request = VerifyCodeRequestModel(resetCode: '123456');
        final response = VerifyCodeResponseModel(status: 'success');
        when(
          mockApiClient.verifyCode(request),
        ).thenAnswer((_) async => response);

        final result = await dataSource.verifyCode(request);

        verify(mockApiClient.verifyCode(request)).called(1);
        expect(result.whenOrNull(success: (data) => data), response);
      },
    );

    test('should return failure BaseResponse when API call fails', () async {
      final request = VerifyCodeRequestModel(resetCode: '123456');
      when(mockApiClient.verifyCode(request)).thenThrow(Exception());

      final result = await dataSource.verifyCode(request);

      verify(mockApiClient.verifyCode(request)).called(1);
      expect(result.whenOrNull(failure: (error) => error), isNotNull);
    });
  });

  group('resetPassword', () {
    test(
      'should return success BaseResponse when API call is successful',
      () async {
        const request = ResetPasswordRequestModel(
          email: 'test@test.com',
          newPassword: 'password',
        );
        const response = ResetPasswordResponseModel(
          message: 'success',
          token: 'token',
        );
        when(
          mockApiClient.resetPassword(request),
        ).thenAnswer((_) async => response);

        final result = await dataSource.resetPassword(request);

        verify(mockApiClient.resetPassword(request)).called(1);
        expect(result.whenOrNull(success: (data) => data), response);
      },
    );

    test('should return failure BaseResponse when API call fails', () async {
      const request = ResetPasswordRequestModel(
        email: 'test@test.com',
        newPassword: 'password',
      );
      when(mockApiClient.resetPassword(request)).thenThrow(Exception());

      final result = await dataSource.resetPassword(request);

      verify(mockApiClient.resetPassword(request)).called(1);
      expect(result.whenOrNull(failure: (error) => error), isNotNull);
    });
  });
}
