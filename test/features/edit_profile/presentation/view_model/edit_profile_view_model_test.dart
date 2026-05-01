import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/upload_photo_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/user_model.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/get_profile_use_case.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/save_first_name_use_case.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/save_photo_use_case.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_states.dart';
import 'package:fitness_app/features/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_view_model_test.mocks.dart';

@GenerateMocks([
  EditProfileUseCase,
  GetProfileUseCase,
  UploadPhotoUseCase,
  SaveFirstNameUseCase,
  SavePhotoUseCase,
])
void main() {
  late EditProfileViewModel editProfileViewModel;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockGetProfileUseCase mockGetProfileUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;
  late MockSaveFirstNameUseCase mockSaveFirstNameUseCase;
  late MockSavePhotoUseCase mockSavePhotoUseCase;
  setUp(() {
    provideDummy<BaseResponse<EditProfileResponseModel>>(
      BaseResponse.success(EditProfileResponseModel()),
    );
    provideDummy<BaseResponse<UploadPhotoResponseModel>>(
      BaseResponse.success(UploadPhotoResponseModel()),
    );
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockGetProfileUseCase = MockGetProfileUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();
    mockSaveFirstNameUseCase = MockSaveFirstNameUseCase();
    mockSavePhotoUseCase = MockSavePhotoUseCase();
    editProfileViewModel = EditProfileViewModel(
      mockEditProfileUseCase,
      mockGetProfileUseCase,
      mockUploadPhotoUseCase,
      mockSaveFirstNameUseCase,
      mockSavePhotoUseCase,
    );
  });
  tearDownAll(() {
    editProfileViewModel.close();
  });
  group('EditProfileEvent test cases', () {
    test('success case with success response', () async {
      final dummyRequest = EditProfileRequestModel(
        firstName: 'Ahmed',
        lastName: 'Salem',
        email: 'ahmedsalem@gmail.com',
      );
      final dummyResponse = EditProfileResponseModel(
        message: 'success',
        userModel: UserModel(
          firstName: 'Ahmed',
          lastName: 'Salem',
          email: 'ahmedsalem@gmail.com',
        ),
      );
      when(mockEditProfileUseCase.call(dummyRequest)).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.success(dummyResponse),
      );
      expectLater(
        editProfileViewModel.stream,
        emitsInOrder([
          predicate<EditProfileStates>(
            (p0) =>
                p0.editProfileState?.isLoading == true &&
                p0.isEditSuccess == false,
          ),
          predicate<EditProfileStates>(
            (p0) =>
                p0.editProfileState?.isLoading == false &&
                p0.editProfileState?.data == dummyResponse &&
                p0.isEditSuccess == true,
          ),
        ]),
      );
      editProfileViewModel.doIntent(EditProfileEvent(dummyRequest));
    });
    test('error case with error response', () async {
      final dummyRequest = EditProfileRequestModel(
        firstName: 'Ahmed',
        lastName: 'Salem',
        email: 'ahmedsalem@gmail.com',
      );
      final dummyException = ExceptionsHandler.handle(
        Exception('Network Error'),
      );
      when(mockEditProfileUseCase.call(dummyRequest)).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.failure(dummyException),
      );
      expectLater(
        editProfileViewModel.stream,
        emitsInOrder([
          predicate<EditProfileStates>(
            (p0) =>
                p0.editProfileState?.isLoading == true &&
                p0.isEditSuccess == false,
          ),
          predicate<EditProfileStates>(
            (p0) =>
                p0.editProfileState?.isLoading == false &&
                p0.editProfileState?.errorMessage == dummyException.message,
          ),
        ]),
      );
      editProfileViewModel.doIntent(EditProfileEvent(dummyRequest));
    });
  });
  group('GetProfileEvent test cases', () {
    test('success case with success response', () async {
      final dummyResponse = EditProfileResponseModel(
        message: 'success',
        userModel: UserModel(
          firstName: 'Ahmed',
          lastName: 'Salem',
          email: 'ahmedsalem@gmail.com',
        ),
      );
      when(mockGetProfileUseCase.call()).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.success(dummyResponse),
      );
      expectLater(
        editProfileViewModel.stream,
        emitsInOrder([
          predicate<EditProfileStates>(
            (p0) => p0.profileState?.isLoading == true,
          ),
          predicate<EditProfileStates>(
            (p0) =>
                p0.profileState?.isLoading == false &&
                p0.profileState?.data == dummyResponse,
          ),
        ]),
      );
      editProfileViewModel.doIntent(GetProfileEvent());
    });
    test('error case with error response', () {
      final dummyException = ExceptionsHandler.handle(
        Exception('Network Error'),
      );
      when(mockGetProfileUseCase.call()).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.failure(dummyException),
      );
      expectLater(
        editProfileViewModel.stream,
        emitsInOrder([
          predicate<EditProfileStates>(
            (p0) => p0.profileState?.isLoading == true,
          ),
          predicate<EditProfileStates>(
            (p0) =>
                p0.profileState?.isLoading == false &&
                p0.profileState?.errorMessage == dummyException.message,
          ),
        ]),
      );
      editProfileViewModel.doIntent(GetProfileEvent());
    });
  });
  group('UploadPhotoEvent test cases', () {
    test('success case with success response', () async {
      final dummyFile = File('test/fixtures/dummy.jpg');
      final dummyResponse = UploadPhotoResponseModel(
        message: 'Photo uploaded successfully',
      );

      when(mockUploadPhotoUseCase.call(dummyFile)).thenAnswer(
        (_) async =>
            BaseResponse<UploadPhotoResponseModel>.success(dummyResponse),
      );

      // Also mock getProfile to avoid issues
      when(mockGetProfileUseCase.call()).thenAnswer(
        (_) async => BaseResponse<EditProfileResponseModel>.success(
          EditProfileResponseModel(),
        ),
      );

      expectLater(
        editProfileViewModel.stream,
        emitsInOrder([
          predicate<EditProfileStates>(
            (state) => state.uploadState?.isLoading == true,
          ),
          predicate<EditProfileStates>(
            (state) =>
                state.uploadState?.isLoading == false &&
                state.uploadState?.data == dummyResponse,
          ),
          predicate<EditProfileStates>(
            (state) => state.profileState?.isLoading == true,
          ),
        ]),
      );

      editProfileViewModel.doIntent(UploadPhotoEvent(dummyFile));
    });

    test('error case with error response', () async {
      final dummyFile = File('test/fixtures/dummy.jpg');
      final dummyException = ExceptionsHandler.handle(
        Exception('Network Error'),
      );

      when(mockUploadPhotoUseCase.call(dummyFile)).thenAnswer(
        (_) async =>
            BaseResponse<UploadPhotoResponseModel>.failure(dummyException),
      );

      expectLater(
        editProfileViewModel.stream,
        emitsInOrder([
          predicate<EditProfileStates>(
            (state) => state.uploadState?.isLoading == true,
          ),
          predicate<EditProfileStates>(
            (state) =>
                state.uploadState?.isLoading == false &&
                state.uploadState?.errorMessage == dummyException.message,
          ),
        ]),
      );

      editProfileViewModel.doIntent(UploadPhotoEvent(dummyFile));
    });
  });

  group('ResetEditSuccessEvent test cases', () {
    test('resets isEditSuccess flag', () async {
      // First set isEditSuccess to true
      editProfileViewModel.emit(
        editProfileViewModel.state.copyWith(isEditSuccess: true),
      );
      expect(editProfileViewModel.state.isEditSuccess, true);

      // Then reset it
      editProfileViewModel.doIntent(ResetEditSuccessEvent());
      expect(editProfileViewModel.state.isEditSuccess, false);
    });
  });

  group('UpdateWeightEvent test cases', () {
    test('success case - updates weight and calls editProfile', () async {
      // First set profile state with user data
      final userModel = UserModel(
        firstName: 'Ahmed',
        lastName: 'Salem',
        email: 'ahmed@test.com',
        weight: 80,
        goal: 'Lose Weight',
        activityLevel: 'level2',
      );
      final profileResponse = EditProfileResponseModel(
        message: 'success',
        userModel: userModel,
      );

      editProfileViewModel.emit(
        editProfileViewModel.state.copyWith(
          profileState: BaseState<EditProfileResponseModel>(
            data: profileResponse,
          ),
        ),
      );

      final dummyResponse = EditProfileResponseModel(
        message: 'success',
        userModel: UserModel(weight: 75),
      );

      when(mockEditProfileUseCase.call(any)).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.success(dummyResponse),
      );

      expectLater(
        editProfileViewModel.stream,
        emitsInOrder([
          predicate<EditProfileStates>(
            (state) => state.editProfileState?.isLoading == true,
          ),
          predicate<EditProfileStates>(
            (state) =>
                state.editProfileState?.isLoading == false &&
                state.isEditSuccess == true,
          ),
        ]),
      );

      editProfileViewModel.doIntent(UpdateWeightEvent(75));
    });
  });

  group('UpdateWeightIndexEvent test cases', () {
    test('updates weight index and selected weight', () async {
      editProfileViewModel.doIntent(UpdateWeightIndexEvent(10, 55));

      expect(editProfileViewModel.state.currentWeightIndex, 10);
      expect(editProfileViewModel.state.selectedWeight, 55);
    });
  });

  group('SelectGoalEvent test cases', () {
    test('updates selected goal', () async {
      editProfileViewModel.doIntent(SelectGoalEvent('Gain Weight'));
      expect(editProfileViewModel.state.selectedGoal, 'Gain Weight');
    });
  });

  group('UpdateGoalEvent test cases', () {
    test('success case - updates goal and calls editProfile', () async {
      final userModel = UserModel(
        firstName: 'Ahmed',
        lastName: 'Salem',
        email: 'ahmed@test.com',
        weight: 80,
        goal: 'Lose Weight',
        activityLevel: 'level2',
      );
      final profileResponse = EditProfileResponseModel(
        message: 'success',
        userModel: userModel,
      );

      editProfileViewModel.emit(
        editProfileViewModel.state.copyWith(
          profileState: BaseState<EditProfileResponseModel>(
            data: profileResponse,
          ),
        ),
      );

      final dummyResponse = EditProfileResponseModel(
        message: 'success',
        userModel: UserModel(goal: 'Gain Weight'),
      );

      when(mockEditProfileUseCase.call(any)).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.success(dummyResponse),
      );

      expectLater(
        editProfileViewModel.stream,
        emitsInOrder([
          predicate<EditProfileStates>(
            (state) => state.editProfileState?.isLoading == true,
          ),
          predicate<EditProfileStates>(
            (state) =>
                state.editProfileState?.isLoading == false &&
                state.isEditSuccess == true,
          ),
        ]),
      );

      editProfileViewModel.doIntent(UpdateGoalEvent('Gain Weight'));
    });
  });

  group('SelectActivityLevelEvent test cases', () {
    test('updates selected activity level', () async {
      editProfileViewModel.doIntent(SelectActivityLevelEvent('level3'));
      expect(editProfileViewModel.state.selectedActivityLevel, 'level3');
    });
  });
  group('UpdateActivityLevelEvent test cases', () {
    test(
      'success case - updates activity level and calls editProfile',
      () async {
        final userModel = UserModel(
          firstName: 'Ahmed',
          lastName: 'Salem',
          email: 'ahmed@test.com',
          weight: 80,
          goal: 'Lose Weight',
          activityLevel: 'level2',
        );
        final profileResponse = EditProfileResponseModel(
          message: 'success',
          userModel: userModel,
        );

        editProfileViewModel.emit(
          editProfileViewModel.state.copyWith(
            profileState: BaseState<EditProfileResponseModel>(
              data: profileResponse,
            ),
          ),
        );

        final dummyResponse = EditProfileResponseModel(
          message: 'success',
          userModel: UserModel(activityLevel: 'level4'),
        );

        when(mockEditProfileUseCase.call(any)).thenAnswer(
          (_) async =>
              BaseResponse<EditProfileResponseModel>.success(dummyResponse),
        );

        expectLater(
          editProfileViewModel.stream,
          emitsInOrder([
            predicate<EditProfileStates>(
              (state) => state.editProfileState?.isLoading == true,
            ),
            predicate<EditProfileStates>(
              (state) =>
                  state.editProfileState?.isLoading == false &&
                  state.isEditSuccess == true,
            ),
          ]),
        );

        editProfileViewModel.doIntent(UpdateActivityLevelEvent('level4'));
      },
    );
  });

  group('SaveFirstNameEvent test cases', () {
    test('success case - saves first name', () async {
      const key = 'user_first_name';
      const value = 'Ahmed';
      const dummyResponse = BaseResponse<bool>.success(true);

      when(
        mockSaveFirstNameUseCase.call(key, value),
      ).thenAnswer((_) async => dummyResponse);

      editProfileViewModel.doIntent(SaveFirstNameEvent(key, value));

      verify(mockSaveFirstNameUseCase.call(key, value)).called(1);
    });
  });

  group('SavePhotoEvent test cases', () {
    test('success case - saves photo', () async {
      const key = 'user_photo';
      const value = 'https://example.com/photo.jpg';
      const dummyResponse = BaseResponse<bool>.success(true);

      when(
        mockSavePhotoUseCase.call(key, value),
      ).thenAnswer((_) async => dummyResponse);

      editProfileViewModel.doIntent(SavePhotoEvent(key, value));

      verify(mockSavePhotoUseCase.call(key, value)).called(1);
    });
  });
}
