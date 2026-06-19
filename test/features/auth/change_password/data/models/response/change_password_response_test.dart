import 'package:fitness_app/features/auth/change_password/data/models/response/change_password_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChangePasswordResponse.success', () {
    final changePasswordResponse = ChangePasswordResponse(
      message: 'success',
      token: 'abc123',
    );
    expect(changePasswordResponse, isA<ChangePasswordResponse>());
    expect(changePasswordResponse.message, isA<String>());
    expect(changePasswordResponse.token, isA<String>());
    expect(changePasswordResponse.toJson(), {
      'message': 'success',
      'token': 'abc123',
    });
  });

  test('ChangePasswordResponse.error', () {
    final changePasswordResponse = ChangePasswordResponse(
      message: 'error',
      token: null,
    );
    expect(changePasswordResponse.message, 'error');
    expect(changePasswordResponse.token, null);
  });

  test('copyWith', () {
    final changePasswordResponse = ChangePasswordResponse(
      message: 'success',
      token: null,
    );
    final response = changePasswordResponse.copyWith(
      message: 'error',
      token: null,
    );
    expect(response, isA<ChangePasswordResponse>());
    expect(response.message, 'error');
    expect(response.token, isNull);
  });
}
