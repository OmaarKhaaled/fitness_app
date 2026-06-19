import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/edit_profile/domain/models/upload_photo_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

void main() {
  late UploadPhotoUseCase uploadPhotoUseCase;
  late MockEditProfileRepoImpl mockEditProfileRepoImpl;
  setUp(() {
    provideDummy<BaseResponse<UploadPhotoResponseModel>>(
      BaseResponse.success(UploadPhotoResponseModel()),
    );
    mockEditProfileRepoImpl = MockEditProfileRepoImpl();
    uploadPhotoUseCase = UploadPhotoUseCase(mockEditProfileRepoImpl);
  });
  group('UploadPhotoUseCase test cases', () {
    test('success case with success response', () async {
      final dummyPhoto = File('https://uloads/dummy-phot.png');
      final dummyResponse = UploadPhotoResponseModel(message: 'Success');
      when(mockEditProfileRepoImpl.uploadPhoto(any)).thenAnswer(
        (_) async =>
            BaseResponse<UploadPhotoResponseModel>.success(dummyResponse),
      );
      final result = await uploadPhotoUseCase.call(dummyPhoto);
      expect(result, isA<BaseResponse<UploadPhotoResponseModel>>());
      expect(
        result.mapOrNull(success: (value) => value.data.message),
        equals(dummyResponse.message),
      );
      verify(mockEditProfileRepoImpl.uploadPhoto(any)).called(1);
    });
    test('error case with error response', () async {
      final dummyPhoto = File('https://uloads/dummy-phot.png');
      final dummyException = ExceptionsHandler.handle(
        Exception('Network Error'),
      );
      when(mockEditProfileRepoImpl.uploadPhoto(any)).thenAnswer(
        (_) async =>
            BaseResponse<UploadPhotoResponseModel>.failure(dummyException),
      );
      final result = await uploadPhotoUseCase.call(dummyPhoto);
      expect(result, isA<BaseResponse<UploadPhotoResponseModel>>());
      expect(
        result.mapOrNull(failure: (value) => value.exception.message),
        equals(dummyException.message),
      );
      verify(mockEditProfileRepoImpl.uploadPhoto(any)).called(1);
    });
  });
}
