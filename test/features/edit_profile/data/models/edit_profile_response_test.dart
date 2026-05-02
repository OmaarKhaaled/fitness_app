import 'package:fitness_app/features/edit_profile/data/models/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/user_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditProfileResponse test cases', () {
    test('fromJson should parse all fields', () {
      final json = {'message': 'message1'};
      final dto = EditProfileResponse.fromJson(json);
      expect(dto.message, equals(json['message']));
    });
    test('toDomain should map all relevant fields', () {
      final dto = EditProfileResponse(
        message: 'message1',
        user: UserDTO(firstName: 'firstName1'),
      );
      final model = dto.toDomain();
      expect(model.message, equals(dto.message));
      expect(model.userModel?.firstName, equals(dto.user?.firstName));
    });
    test('toJson should serialize all fields', () {
      final dto = EditProfileResponse(
        message: 'message1',
        user: UserDTO(firstName: 'firstName1'),
      );
      final json = dto.toJson();
      expect(json['message'], equals(dto.message));
      expect((json['user'] as UserDTO).firstName, equals(dto.user?.firstName));
    });
  });
}
