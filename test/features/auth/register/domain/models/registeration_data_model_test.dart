import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toRegisterRequest should map all relevant fields', () {
    final data = RegisterationDataModel(
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
    final model = data.toRegisterRequest();
    expect(model.firstName, equals(data.firstName));
    expect(model.lastName, equals(data.lastName));
    expect(model.email, equals(data.email));
    expect(model.password, equals(data.password));
    expect(model.rePassword, equals(data.rePassword));
    expect(model.gender, equals(data.gender));
    expect(model.age, equals(data.age));
    expect(model.weight, equals(data.weight));
    expect(model.height, equals(data.height));
    expect(model.goal, equals(data.goal));
    expect(model.activityLevel, equals(data.activityLevel));
  });
}
