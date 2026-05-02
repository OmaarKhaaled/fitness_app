import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/cache_modules/secure_storege_module.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/features/edit_profile/api/data_sources/local/edit_profile_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_local_data_source_impl_test.mocks.dart';

@GenerateMocks([SecureStorageService])
void main() {
  late EditProfileLocalDataSourceImpl localDataSourceImpl;
  late MockSecureStorageService mockSecureStorageService;

  setUp(() {
    mockSecureStorageService = MockSecureStorageService();
    localDataSourceImpl = EditProfileLocalDataSourceImpl(
      mockSecureStorageService,
    );
  });

  group('EditProfileLocalDataSourceImpl test cases', () {
    test('testing saveFirstName method success', () async {
      const key = 'user_first_name';
      const value = 'Ahmed';
      const dummyResponse = BaseResponse<bool>.success(true);

      when(
        mockSecureStorageService.write(key, value),
      ).thenAnswer((_) async => dummyResponse);

      final result = await localDataSourceImpl.saveFirstName(key, value);

      expect(result, isA<BaseResponse<bool>>());
      expect(result, dummyResponse);
      verify(mockSecureStorageService.write(key, value)).called(1);
    });

    test('testing saveFirstName method failure', () async {
      const key = 'user_first_name';
      const value = 'Ahmed';
      const exception = AppException('Storage error');
      const dummyResponse = BaseResponse<bool>.failure(exception);

      when(
        mockSecureStorageService.write(key, value),
      ).thenAnswer((_) async => dummyResponse);

      final result = await localDataSourceImpl.saveFirstName(key, value);

      expect(result, isA<BaseResponse<bool>>());
      expect(
        result.mapOrNull(failure: (value) => value.exception),
        equals(exception),
      );
      verify(mockSecureStorageService.write(key, value)).called(1);
    });

    test('testing savePhoto method success', () async {
      const key = 'user_photo';
      const value = 'https://example.com/photo.jpg';
      const dummyResponse = BaseResponse<bool>.success(true);

      when(
        mockSecureStorageService.write(key, value),
      ).thenAnswer((_) async => dummyResponse);

      final result = await localDataSourceImpl.savePhoto(key, value);

      expect(result, isA<BaseResponse<bool>>());
      expect(result, dummyResponse);
      verify(mockSecureStorageService.write(key, value)).called(1);
    });

    test('testing savePhoto method failure', () async {
      const key = 'user_photo';
      const value = 'https://example.com/photo.jpg';
      const exception = AppException('Storage error');
      const dummyResponse = BaseResponse<bool>.failure(exception);

      when(
        mockSecureStorageService.write(key, value),
      ).thenAnswer((_) async => dummyResponse);

      final result = await localDataSourceImpl.savePhoto(key, value);

      expect(result, isA<BaseResponse<bool>>());
      expect(
        result.mapOrNull(failure: (value) => value.exception),
        equals(exception),
      );
      verify(mockSecureStorageService.write(key, value)).called(1);
    });
  });
}
