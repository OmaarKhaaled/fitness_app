import 'package:fitness_app/features/auth/register/data/models/register_request_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterRequestDTO test cases', () {
    test('fromJson should parse all fields', () {
      final json = {
        'firstName': 'firstName1',
        'lastName': 'lastName1',
        'email': 'email1',
        'password': 'password1',
        'rePassword': 'rePassword1',
        'gender': 'male',
        'height': 180,
        'age': 33,
        'weight': 100,
        'goal': 'goal1',
        'activityLevel': 'activityLevel1',
      };
      final dto = RegisterRequestDto.fromJson(json);
      expect(dto.firstName, equals(json['firstName']));
      expect(dto.lastName, equals(json['lastName']));
      expect(dto.email, equals(json['email']));
      expect(dto.password, equals(json['password']));
      expect(dto.rePassword, equals(json['rePassword']));
      expect(dto.gender, equals(json['gender']));
      expect(dto.age, equals(json['age']));
      expect(dto.weight, equals(json['weight']));
      expect(dto.activityLevel, equals(json['activityLevel']));
    });
    test('toJson should serialize all fields', () {
      final dto = RegisterRequestDto(
        firstName: 'firstName1',
        lastName: 'lastName1',
        email: 'email1',
        password: 'password1',
        rePassword: 'rePassword1',
        gender: 'male',
        age: 33,
        weight: 100,
        goal: 'goal1',
        activityLevel: 'activityLevel1',
      );
      final json = dto.toJson();
      expect(json['firstName'], equals(dto.firstName));
      expect(json['lastName'], equals(dto.lastName));
      expect(json['email'], equals(dto.email));
      expect(json['password'], equals(dto.password));
      expect(json['rePassword'], equals(dto.rePassword));
      expect(json['gender'], equals(dto.gender));
      expect(json['age'], equals(dto.age));
      expect(json['weight'], equals(dto.weight));
      expect(json['goal'], equals(dto.goal));
      expect(json['activityLevel'], equals(dto.activityLevel));
    });
  });
}
