import 'package:fitness_app/features/auth/login/data/models/response/user_model.dart';
import 'package:fitness_app/features/auth/login/domain/models/login_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginModel', () {
    test('should initialize with correct values', () {
      final loginModel = LoginModel(
        message: 'Login successful',
        token: 'token123',
        user: User(
          id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
        ),
      );
      expect(loginModel.message, 'Login successful');
      expect(loginModel.token, 'token123');
      expect(loginModel.user.id, '1');
      expect(loginModel.user.firstName, 'John');
      expect(loginModel.user.lastName, 'Doe');
      expect(loginModel.user.email, 'john@example.com');
    });
  });
}
