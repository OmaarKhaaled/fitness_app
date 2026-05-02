import 'package:fitness_app/features/edit_profile/data/models/user_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserDTO test cases', () {
    test('fromJson should parse all fields', () {
      final json = {
        'firstName': 'firstName1',
        'lastName': 'lastName1',
        'email': 'email1',
        'gender': 'male',
        'age': 33,
        'weight': 100,
        'height': 178,
        'activityLevel': 'activityLevel1',
        'goal': 'goal1',
        'photo': 'photo1',
        '_id': '_id1',
      };
      final dto = UserDTO.fromJson(json);
      expect(dto.firstName, equals(json['firstName']));
      expect(dto.lastName, equals(json['lastName']));
      expect(dto.email, equals(json['email']));
      expect(dto.gender, equals(json['gender']));
      expect(dto.age, equals(json['age']));
      expect(dto.weight, equals(json['weight']));
      expect(dto.height, equals(json['height']));
      expect(dto.activityLevel, equals(json['activityLevel']));
      expect(dto.goal, equals(json['goal']));
      expect(dto.photo, equals(json['photo']));
      expect(dto.id, equals(json['_id']));
    });
    test('toDomain should map relevant fields', () {
      final dto = UserDTO(firstName: 'firstName1', lastName: 'lastName1');
      final model = dto.toDomain();
      expect(model.firstName, equals(dto.firstName));
      expect(model.lastName, equals(dto.lastName));
    });
    test('toJson should serialize all fields', () {
      final dto = UserDTO(
        firstName: 'firstName1',
        lastName: 'lastName1',
        email: 'email1',
        gender: 'male',
        age: 33,
        weight: 100,
        height: 178,
        activityLevel: 'activityLevel1',
        goal: 'goal1',
        photo: 'photo1',
        id: 'id1',
        createdAt: DateTime(2027, 1, 1),
      );
      final json = dto.toJson();
      expect(json['firstName'], equals(dto.firstName));
      expect(json['lastName'], equals(dto.lastName));
      expect(json['email'], equals(dto.email));
      expect(json['gender'], equals(dto.gender));
      expect(json['age'], equals(dto.age));
      expect(json['weight'], equals(dto.weight));
      expect(json['height'], equals(dto.height));
      expect(json['activityLevel'], equals(dto.activityLevel));
      expect(json['photo'], equals(dto.photo));
      expect(json['_id'], equals(dto.id));
      expect(json['createdAt'], equals(dto.createdAt?.toIso8601String()));
    });
  });
}
