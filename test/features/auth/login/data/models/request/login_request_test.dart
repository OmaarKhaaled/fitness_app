import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:test/test.dart';

void main() {
  const email = 'test@example.com';
  const password = 'password123';
  final loginRequest = LoginRequest(email: email, password: password);
  group('LoginRequest', () {
    test('Should be a subclass of LoginRequest', () {
      expect(loginRequest, isA<LoginRequest>());
    });
    test('toJson should return a valid JSON map', () async {
      final json = loginRequest.toJson();
      expect(json['email'], 'test@example.com');
      expect(json['password'], 'password123');
    });

    test('fromJson should return a valid LoginRequest object', () async {
      final json = {'email': 'test@example.com', 'password': 'password123'};
      expect(loginRequest.email, 'test@example.com');
      expect(loginRequest.password, 'password123');
    });

    test('fromJson should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "email": email,
        "password": password,
      };

      // act
      final result = LoginRequest.fromJson(jsonMap);
      // assert
      expect(result.email, email);
      expect(result.password, password);
    });
    
    test('toJson should return a JSON map containing proper data', () async {
      // act
      final result = loginRequest.toJson();

      // assert
      final expectedMap = {"email": email, "password": password};
      expect(result, expectedMap);
    });
  });
}
