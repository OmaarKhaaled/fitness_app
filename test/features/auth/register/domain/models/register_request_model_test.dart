import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('making sure that toDTO map all relevant fields', () {
    final model = RegisterRequestModel(
      firstName: 'firstName1',
      lastName: 'lastName1',
      email: 'email1',
      password: 'password1',
      rePassword: 'rePassword1',
      gender: 'male',
      age: 33,
      weight: 100,
      height: 178,
      goal: 'goal1',
      activityLevel: 'activityLevel1',
    );
    final dto = model.toDTO();
    expect(dto.firstName, equals(model.firstName));
    expect(dto.lastName, equals(model.lastName));
    expect(dto.email, equals(model.email));
    expect(dto.password, equals(model.password));
    expect(dto.rePassword, equals(model.rePassword));
    expect(dto.gender, equals(model.gender));
    expect(dto.age, equals(model.age));
    expect(dto.weight, equals(model.weight));
    expect(dto.height, equals(model.height));
    expect(dto.goal, equals(model.goal));
    expect(dto.activityLevel, equals(model.activityLevel));
  });
}
