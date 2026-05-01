import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/edit_profile/api/data_sources/local/edit_profile_local_data_source_impl.dart';
import 'package:fitness_app/features/edit_profile/api/data_sources/remote/edit_profile_remote_data_source_impl.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_photo_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/user_dto.dart';
import 'package:fitness_app/features/edit_profile/data/repos/edit_profile_repo_impl.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/upload_photo_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_repo_impl_test.mocks.dart';

@GenerateMocks([
  EditProfileRemoteDataSourceImpl,
  EditProfileLocalDataSourceImpl,
])
void main() {
  late EditProfileRepoImpl repoImpl;
  late MockEditProfileRemoteDataSourceImpl mockEditProfileRemoteDataSourceImpl;
  late MockEditProfileLocalDataSourceImpl mockEditProfileLocalDataSourceImpl;
  setUp(() {
    provideDummy<BaseResponse<UploadPhotoResponse>>(
      BaseResponse.success(UploadPhotoResponse()),
    );
    provideDummy<BaseResponse<EditProfileResponse>>(
      BaseResponse.success(EditProfileResponse()),
    );
    mockEditProfileRemoteDataSourceImpl = MockEditProfileRemoteDataSourceImpl();
    mockEditProfileLocalDataSourceImpl = MockEditProfileLocalDataSourceImpl();
    repoImpl = EditProfileRepoImpl(
      mockEditProfileRemoteDataSourceImpl,
      mockEditProfileLocalDataSourceImpl,
    );
  });
  group('EditProfileRepoImpl test cases', () {
    group('editProfile() test cases', () {
      test('success case with success response', () async {
        final dummyRequest = EditProfileRequestModel(
          firstName: 'firstName1',
          lastName: 'lastName1',
        );
        final dummyResponse = EditProfileResponse(
          message: 'message1',
          user: UserDTO(firstName: 'firstName1', lastName: 'lastName1'),
        );
        when(mockEditProfileRemoteDataSourceImpl.editProfile(any)).thenAnswer(
          (_) async => BaseResponse<EditProfileResponse>.success(dummyResponse),
        );
        final result = await repoImpl.editProfile(dummyRequest);
        expect(result, isA<BaseResponse<EditProfileResponseModel>>());
        expect(
          result.mapOrNull(success: (value) => value.data.message),
          equals(dummyResponse.message),
        );
        expect(
          result.mapOrNull(success: (value) => value.data.userModel?.firstName),
          equals(dummyResponse.user?.firstName),
        );
        expect(
          result.mapOrNull(success: (value) => value.data.userModel?.lastName),
          equals(dummyResponse.user?.lastName),
        );
        verify(mockEditProfileRemoteDataSourceImpl.editProfile(any)).called(1);
      });
      test('error case with error response', () async {
        final dummyRequest = EditProfileRequestModel(
          firstName: 'firstName1',
          lastName: 'lastName1',
        );
        final dummyException = ExceptionsHandler.handle(
          Exception('Network Error'),
        );
        when(mockEditProfileRemoteDataSourceImpl.editProfile(any)).thenAnswer(
          (_) async =>
              BaseResponse<EditProfileResponse>.failure(dummyException),
        );
        final result = await repoImpl.editProfile(dummyRequest);
        expect(result, isA<BaseResponse<EditProfileResponseModel>>());
        expect(
          result.mapOrNull(failure: (value) => value.exception.message),
          equals(dummyException.message),
        );
        verify(mockEditProfileRemoteDataSourceImpl.editProfile(any)).called(1);
      });
    });
    group('getProfile() test cases', () {
      test('success case with success response', () async {
        final dummyResponse = EditProfileResponse(
          message: 'message1',
          user: UserDTO(firstName: 'firstName1', lastName: 'lastName1'),
        );
        when(mockEditProfileRemoteDataSourceImpl.getProfile()).thenAnswer(
          (_) async => BaseResponse<EditProfileResponse>.success(dummyResponse),
        );
        final result = await repoImpl.getProfile();
        expect(result, isA<BaseResponse<EditProfileResponseModel>>());
        expect(
          result.mapOrNull(success: (value) => value.data.message),
          equals(dummyResponse.message),
        );
        expect(
          result.mapOrNull(success: (value) => value.data.userModel?.firstName),
          equals(dummyResponse.user?.firstName),
        );
        expect(
          result.mapOrNull(success: (value) => value.data.userModel?.lastName),
          equals(dummyResponse.user?.lastName),
        );
        verify(mockEditProfileRemoteDataSourceImpl.getProfile()).called(1);
      });
      test('error case with error response', () async {
        final dummyException = ExceptionsHandler.handle(
          Exception('Network Error'),
        );
        when(mockEditProfileRemoteDataSourceImpl.getProfile()).thenAnswer(
          (_) async =>
              BaseResponse<EditProfileResponse>.failure(dummyException),
        );
        final result = await repoImpl.getProfile();
        expect(result, isA<BaseResponse<EditProfileResponseModel>>());
        expect(
          result.mapOrNull(failure: (value) => value.exception.message),
          equals(dummyException.message),
        );
        verify(mockEditProfileRemoteDataSourceImpl.getProfile()).called(1);
      });
    });
    group('uploadPhoto test cases', () {
      test('success case with success response', () async {
        final dummyPhoto = File('https://dummypath');
        final dummyRespone = UploadPhotoResponse(message: 'Success');
        when(mockEditProfileRemoteDataSourceImpl.uploadPhoto(any)).thenAnswer(
          (_) async => BaseResponse<UploadPhotoResponse>.success(dummyRespone),
        );
        final result = await repoImpl.uploadPhoto(dummyPhoto);
        expect(result, isA<BaseResponse<UploadPhotoResponseModel>>());
        expect(
          result.mapOrNull(success: (value) => value.data.message),
          equals(dummyRespone.message),
        );
        verify(mockEditProfileRemoteDataSourceImpl.uploadPhoto(any)).called(1);
      });
      test('error case with error response', () async {
        final dummyPhoto = File('https://dummypath');
        final dummyException = ExceptionsHandler.handle(
          Exception('Network Error'),
        );
        when(mockEditProfileRemoteDataSourceImpl.uploadPhoto(any)).thenAnswer(
          (_) async =>
              BaseResponse<UploadPhotoResponse>.failure(dummyException),
        );
        final result = await repoImpl.uploadPhoto(dummyPhoto);
        expect(result, isA<BaseResponse<UploadPhotoResponseModel>>());
        expect(
          result.mapOrNull(failure: (value) => value.exception.message),
          equals(dummyException.message),
        );
        verify(mockEditProfileRemoteDataSourceImpl.uploadPhoto(any)).called(1);
      });
    });
    group('saveFirstName() test cases', () {
      test('success case with success response', () async {
        const key = 'user_first_name';
        const value = 'Ahmed';
        const dummyResponse = BaseResponse<bool>.success(true);

        when(
          mockEditProfileLocalDataSourceImpl.saveFirstName(key, value),
        ).thenAnswer((_) async => dummyResponse);

        final result = await mockEditProfileLocalDataSourceImpl.saveFirstName(
          key,
          value,
        );

        expect(result, isA<BaseResponse<bool>>());
        expect(result, dummyResponse);
        verify(
          mockEditProfileLocalDataSourceImpl.saveFirstName(key, value),
        ).called(1);
      });
      test('error case with error response', () async {
        const key = 'user_first_name';
        const value = 'Ahmed';
        final dummyException = ExceptionsHandler.handle(
          Exception('Storage Error'),
        );
        final dummyResponse = BaseResponse<bool>.failure(dummyException);
        when(
          mockEditProfileLocalDataSourceImpl.saveFirstName(key, value),
        ).thenAnswer((_) async => dummyResponse);
        final result = await mockEditProfileLocalDataSourceImpl.saveFirstName(
          key,
          value,
        );
        expect(result, isA<BaseResponse<bool>>());
        expect(
          result.mapOrNull(failure: (value) => value.exception),
          equals(dummyException),
        );
        verify(
          mockEditProfileLocalDataSourceImpl.saveFirstName(key, value),
        ).called(1);
      });
    });
    group('savePhoto() use cases', () {
      test('success case with success response', () async {
        const key = 'user_photo';
        const value = 'https://example.com/photo.jpg';
        const dummyResponse = BaseResponse<bool>.success(true);

        when(
          mockEditProfileLocalDataSourceImpl.savePhoto(key, value),
        ).thenAnswer((_) async => dummyResponse);

        final result = await repoImpl.savePhoto(key, value);

        expect(result, isA<BaseResponse<bool>>());
        expect(result, dummyResponse);
        verify(
          mockEditProfileLocalDataSourceImpl.savePhoto(key, value),
        ).called(1);
      });
      test('testing savePhoto method failure', () async {
        const key = 'user_photo';
        const value = 'https://example.com/photo.jpg';
        const exception = AppException('Storage error');
        const dummyResponse = BaseResponse<bool>.failure(exception);

        when(
          mockEditProfileLocalDataSourceImpl.savePhoto(key, value),
        ).thenAnswer((_) async => dummyResponse);

        final result = await repoImpl.savePhoto(key, value);

        expect(result, isA<BaseResponse<bool>>());
        expect(
          result.mapOrNull(failure: (value) => value.exception),
          equals(exception),
        );
        verify(
          mockEditProfileLocalDataSourceImpl.savePhoto(key, value),
        ).called(1);
      });
    });
  });
}
