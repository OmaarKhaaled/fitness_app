import 'package:fitness_app/features/edit_profile/data/models/upload_photo_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UploadPhotoResponse test cases', () {
    test('fromJson should parse fields', () {
      final json = {'message': 'message1'};
      final dto = UploadPhotoResponse.fromJson(json);
      expect(dto.message, equals(json['message']));
    });
    test('toDomain should map relevant fields', () {
      final dto = UploadPhotoResponse(message: 'message1');
      final model = dto.toDomain();
      expect(model.message, equals(dto.message));
    });
    test('toJson should serialize fields', () {
      final dto = UploadPhotoResponse(message: 'message1');
      final json = dto.toJson();
      expect(json['message'], equals(dto.message));
    });
  });
}
