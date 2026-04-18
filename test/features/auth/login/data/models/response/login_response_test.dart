import 'package:fitness_app/features/auth/login/data/models/response/login_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
const message = 'Login successful';
const token = 'abc123';
final loginResponse = LoginResponse(message: message, token: token);
group('LoginResponse', () {
  test('has correct message', () {
    expect(loginResponse.message, equals(message));
  });
  test('has correct token', () {
    expect(loginResponse.token, equals(token));
  });
});


}