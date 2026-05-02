import 'package:fitness_app/features/edit_profile/data/models/edit_profile_request_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditProfileRequestDto test cases', () {
    test('fromJson should parse all fields', () {
      final json = {
        'firstName': 'firstName1',
        'lastName': 'lastName1',
        'email': 'email1',
        'weight': 98,
        'goal': 'goal1',
        'activityLevel': 'activityLevel1',
      };
      final dto = EditProfileRequestDto.fromJson(json);
      expect(dto.firstName, equals(json['firstName']));
      expect(dto.lastName, equals(json['lastName']));
      expect(dto.email, equals(json['email']));
      expect(dto.weight, equals(json['weight']));
      expect(dto.goal, equals(json['goal']));
      expect(dto.activityLevel, equals(json['activityLevel']));
    });
    test('toJson should serialize all fields', () {
      final dto = EditProfileRequestDto(
        firstName: 'firstName1',
        lastName: 'lastName1',
        email: 'email1',
        weight: 98,
        goal: 'goal1',
        activityLevel: 'level1',
      );
      final json = dto.toJson();
      expect(json['firstName'], equals(dto.firstName));
      expect(json['lastName'], equals(dto.lastName));
      expect(json['email'], equals(dto.email));
      expect(json['weight'], equals(dto.weight));
      expect(json['goal'], equals(dto.goal));
      expect(json['activityLevel'], equals(dto.activityLevel));
    });
  });
}
