import 'package:fitness_app/features/auth/login/data/models/response/login_response.dart';
import 'package:fitness_app/features/auth/login/data/models/response/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const message = 'Login successful';
  const token = 'abc123';
  User user = User(id: '1', firstName: 'John', email: 'john@example.com');
  final loginResponse = LoginResponse(message: message, token: token),
      loginResponseWithUser = LoginResponse(
        message: message,
        token: token,
        user: user,
      );
  group('LoginResponse', () {
    test('should be a subclass of LoginResponse Entity', () {
      expect(loginResponse, isA<LoginResponse>());
    });

    test('fromJson should return a valid model', () {
      final Map<String, dynamic> jsonmap = {
        'message': message,
        'token': token,
        'user': user.toJson(),
      };
      final result = LoginResponse.fromJson(jsonmap);
      expect(result.message, message);
      expect(result.token, token);
      expect(result.user!.id, user.id);
      expect(result.user!.firstName, user.firstName);
      expect(result.user!.email, user.email);
    });
    test('tojson should return proper data', () {
      final result = LoginResponse(
        message: message,
        token: token,
        user: user,
      ).toJson();
      final expectedMap = {
        'message': message,
        'token': token,
        'user': user.toJson(),
      };

      expect(result, equals(expectedMap));
    });
    test('has correct message', () {
      expect(loginResponse.message, equals(message));
    });
    test('has correct token', () {
      expect(loginResponse.token, equals(token));
    });
  });
}
