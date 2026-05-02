import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:fitness_app/features/edit_profile/api/data_sources/remote/edit_profile_remote_data_source_impl.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile_request_dto.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_photo_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/user_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([EditProfileApiClient])
void main() {
  late EditProfileRemoteDataSourceImpl remoteDataSourceImpl;
  late MockEditProfileApiClient mockEditProfileApiClient;
  setUp(() {
    mockEditProfileApiClient = MockEditProfileApiClient();
    remoteDataSourceImpl = EditProfileRemoteDataSourceImpl(
      mockEditProfileApiClient,
    );
  });
  group('EditProfileDataSourceImpl test cases', () {
    test('testing the functionality of edit profile method', () async {
      final dummyRequest = EditProfileRequestDto(
        firstName: 'Ahmed',
        lastName: 'Salem',
        email: 'ahmed@gmail.com',
        weight: 78,
        goal: 'gain weight',
        activityLevel: 'level2',
      );
      final dummyResponse = EditProfileResponse(
        message: 'success',
        user: UserDTO(),
      );
      when(
        mockEditProfileApiClient.editProfile(dummyRequest),
      ).thenAnswer((_) async => dummyResponse);
      final result = await remoteDataSourceImpl.editProfile(dummyRequest);
      expect(result, isA<BaseResponse<EditProfileResponse>>());
      expect(result, BaseResponse<EditProfileResponse>.success(dummyResponse));
      expect(
        result.mapOrNull(success: (value) => value.data.message),
        equals(dummyResponse.message),
      );
      expect(
        result.mapOrNull(success: (value) => value.data.user),
        equals(dummyResponse.user),
      );
      verify(mockEditProfileApiClient.editProfile(dummyRequest)).called(1);
    });
    test('checking getProfile method', () async {
      final dummyResponse = EditProfileResponse(
        message: 'success',
        user: UserDTO(),
      );
      when(
        mockEditProfileApiClient.getProfile(),
      ).thenAnswer((_) async => dummyResponse);
      final result = await remoteDataSourceImpl.getProfile();
      expect(result, BaseResponse<EditProfileResponse>.success(dummyResponse));
      expect(
        result.mapOrNull(success: (value) => value.data.message),
        equals(dummyResponse.message),
      );
      expect(
        result.mapOrNull(success: (value) => value.data.user),
        equals(dummyResponse.user),
      );
      verify(mockEditProfileApiClient.getProfile()).called(1);
    });
    test('testing the functionality of upload photo method', () async {
      final dummyResponse = UploadPhotoResponse(
        message: 'Photo uploaded successfully',
      );

      when(
        mockEditProfileApiClient.uploadPhoto(any),
      ).thenAnswer((_) async => dummyResponse);
      final dummyPhoto = File('test/fixtures/dummy.jpg');

      final result = await remoteDataSourceImpl.uploadPhoto(dummyPhoto);

      expect(result, isA<BaseResponse<UploadPhotoResponse>>());
      expect(result, BaseResponse<UploadPhotoResponse>.success(dummyResponse));
      verify(mockEditProfileApiClient.uploadPhoto(any)).called(1);
    });
  });
}
