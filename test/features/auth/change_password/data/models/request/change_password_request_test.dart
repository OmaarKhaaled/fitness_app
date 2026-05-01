import 'package:fitness_app/features/auth/change_password/data/models/request/change_password_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChangePasswordRequest.success', () async {
    final request = ChangePasswordRequest(
      password: '123',
      newPassword: '12345',
    );
    expect(request, isA<ChangePasswordRequest>());
    expect(request.password, isA<String>());
    expect(request.newPassword, isA<String>());
    expect(request.toJson(), {'password': '123', 'newPassword': '12345'});
  });

  test('ChangePasswordRequest.error', () {
    final request = ChangePasswordRequest(password: null, newPassword: null);
    expect(request, isA<ChangePasswordRequest>());
    expect(request.newPassword, null);
    expect(request.password, null);
  });
}
