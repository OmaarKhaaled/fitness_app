import 'package:fitness_app/features/auth/register/data/models/register_response.dart';
import 'package:fitness_app/features/auth/register/data/models/user_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterResponse test cases', () {
    test('fromJson should parse all fields', () {
      final json = {'message': 'message1', 'token': 'token1'};
      final dto = RegisterResponse.fromJson(json);
      expect(dto.message, equals(json['message']));
      expect(dto.token, equals(json['token']));
    });
    test('toDomain should map all relevant fields', () {
      final dto = RegisterResponse(
        message: 'message1',
        user: UserDTO(firstName: 'firstName1'),
        token: 'token1',
      );
      final model = dto.toDomain();
      expect(model.message, equals(dto.message));
      expect(model.user?.firstName, equals(dto.user?.firstName));
      expect(model.token, equals(dto.token));
    });
    test('toJson should serialize all fields', () {
      final dto = RegisterResponse(
        message: 'message1',
        user: UserDTO(firstName: 'firstName1'),
        token: 'token1',
      );
      final json = dto.toJson();
      expect(json['message'], equals(dto.message));
      expect((json['user'] as UserDTO).firstName, equals(dto.user?.firstName));
      expect(json['token'], equals(dto.token));
    });
  });
}
