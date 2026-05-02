import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/save_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

void main() {
  late SavePhotoUseCase savePhotoUseCase;
  late MockEditProfileRepoImpl mockEditProfileRepoImpl;
  setUp(() {
    mockEditProfileRepoImpl = MockEditProfileRepoImpl();
    savePhotoUseCase = SavePhotoUseCase(mockEditProfileRepoImpl);
  });
  group('SavePhotoUseCase test cases', () {
    test('success case with success response', () async {
      const key = 'user_photo';
      const value = 'https://example.com/photo.jpg';
      const dummyResponse = BaseResponse<bool>.success(true);

      when(
        mockEditProfileRepoImpl.savePhoto(key, value),
      ).thenAnswer((_) async => dummyResponse);

      final result = await savePhotoUseCase.call(key, value);

      expect(result, isA<BaseResponse<bool>>());
      expect(result, dummyResponse);
      verify(mockEditProfileRepoImpl.savePhoto(key, value)).called(1);
    });
    test('testing savePhoto method failure', () async {
      const key = 'user_photo';
      const value = 'https://example.com/photo.jpg';
      const exception = AppException('Storage error');
      const dummyResponse = BaseResponse<bool>.failure(exception);

      when(
        mockEditProfileRepoImpl.savePhoto(key, value),
      ).thenAnswer((_) async => dummyResponse);

      final result = await savePhotoUseCase.call(key, value);

      expect(result, isA<BaseResponse<bool>>());
      expect(
        result.mapOrNull(failure: (value) => value.exception),
        equals(exception),
      );
      verify(mockEditProfileRepoImpl.savePhoto(key, value)).called(1);
    });
  });
}
