import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const email = 'test@example.com';
  const password = 'password123';
  final loginRequest = LoginRequest(email: email, password: password);
  group('LoginRequest', () {
    test('Should be a subclass of LoginRequest', () {
      expect(loginRequest, isA<LoginRequest>());
    });
    test('has correct email', () {
      expect(loginRequest.email, equals(email));
    });
    test('has correct password', () {
      expect(loginRequest.password, equals(password));
    });
  });
}
