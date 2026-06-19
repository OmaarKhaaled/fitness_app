import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/edit_profile/data/repos/edit_profile_repo_impl.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/user_model.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepoImpl])
void main() {
  late EditProfileUseCase editProfileUseCase;
  late MockEditProfileRepoImpl mockEditProfileRepoImpl;
  setUp(() {
    provideDummy<BaseResponse<EditProfileResponseModel>>(
      BaseResponse.success(EditProfileResponseModel()),
    );
    mockEditProfileRepoImpl = MockEditProfileRepoImpl();
    editProfileUseCase = EditProfileUseCase(mockEditProfileRepoImpl);
  });
  group('EditProfileUseCase test cases', () {
    test('success case with success response', () async {
      final dummyRequest = EditProfileRequestModel(
        activityLevel: 'level4',
        weight: 88,
      );
      final dummyResponse = EditProfileResponseModel(
        message: 'success',
        userModel: UserModel(activityLevel: 'level4', weight: 88),
      );
      when(mockEditProfileRepoImpl.editProfile(dummyRequest)).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.success(dummyResponse),
      );
      final result = await editProfileUseCase.call(dummyRequest);
      expect(result, isA<BaseResponse<EditProfileResponseModel>>());
      expect(
        result.mapOrNull(success: (value) => value.data.message),
        equals(dummyResponse.message),
      );
      expect(
        result.mapOrNull(
          success: (value) => value.data.userModel?.activityLevel,
        ),
        equals(dummyResponse.userModel?.activityLevel),
      );
      expect(
        result.mapOrNull(success: (value) => value.data.userModel?.weight),
        equals(dummyResponse.userModel?.weight),
      );
      verify(mockEditProfileRepoImpl.editProfile(dummyRequest)).called(1);
    });
    test('error case with error exception', () async {
      final dummyRequest = EditProfileRequestModel(
        activityLevel: 'level4',
        weight: 88,
      );
      final dummyException = ExceptionsHandler.handle(
        Exception('Network Error'),
      );
      when(mockEditProfileRepoImpl.editProfile(dummyRequest)).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.failure(dummyException),
      );
      final result = await editProfileUseCase.call(dummyRequest);
      expect(result, isA<BaseResponse<EditProfileResponseModel>>());
      expect(
        result.mapOrNull(failure: (value) => value.exception.message),
        equals(dummyException.message),
      );
      verify(mockEditProfileRepoImpl.editProfile(dummyRequest)).called(1);
    });
  });
}
