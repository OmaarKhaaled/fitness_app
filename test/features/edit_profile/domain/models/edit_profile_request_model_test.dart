import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('making sure that toDTO should map all relevant fields', () {
    final model = EditProfileRequestModel(
      activityLevel: 'level1',
      email: 'email1',
      firstName: 'firstName1',
      lastName: 'lastName1',
      goal: 'goal1',
      weight: 88,
    );
    final dto = model.toDTO();
    expect(dto.activityLevel, equals(model.activityLevel));
    expect(dto.email, equals(model.email));
    expect(dto.firstName, equals(model.firstName));
    expect(dto.lastName, equals(model.lastName));
    expect(dto.goal, equals(model.goal));
    expect(dto.weight, equals(model.weight));
  });
}
