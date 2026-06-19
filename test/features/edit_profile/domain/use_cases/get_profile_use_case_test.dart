import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/user_model.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

void main() {
  late GetProfileUseCase getProfileUseCase;
  late MockEditProfileRepoImpl mockEditProfileRepoImpl;
  setUp(() {
    provideDummy<BaseResponse<EditProfileResponseModel>>(
      BaseResponse.success(EditProfileResponseModel()),
    );
    mockEditProfileRepoImpl = MockEditProfileRepoImpl();
    getProfileUseCase = GetProfileUseCase(mockEditProfileRepoImpl);
  });
  group('GetProfileUseCase test cases', () {
    test('success case with success response', () async {
      final dummyResponse = EditProfileResponseModel(
        message: 'success',
        userModel: UserModel(firstName: 'firstName1', lastName: 'lastName1'),
      );
      when(mockEditProfileRepoImpl.getProfile()).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.success(dummyResponse),
      );
      final result = await getProfileUseCase.call();
      expect(result, isA<BaseResponse<EditProfileResponseModel>>());
      expect(
        result.mapOrNull(success: (value) => value.data.message),
        equals(dummyResponse.message),
      );
      expect(
        result.mapOrNull(success: (value) => value.data.userModel?.firstName),
        equals(dummyResponse.userModel?.firstName),
      );
      expect(
        result.mapOrNull(success: (value) => value.data.userModel?.lastName),
        equals(dummyResponse.userModel?.lastName),
      );
      verify(mockEditProfileRepoImpl.getProfile()).called(1);
    });
    test('error case with error response', () async {
      final dummyException = ExceptionsHandler.handle(
        Exception('Network Error'),
      );
      when(mockEditProfileRepoImpl.getProfile()).thenAnswer(
        (_) async =>
            BaseResponse<EditProfileResponseModel>.failure(dummyException),
      );
      final result = await getProfileUseCase.call();
      expect(result, isA<BaseResponse<EditProfileResponseModel>>());
      expect(
        result.mapOrNull(failure: (value) => value.exception.message),
        equals(dummyException.message),
      );
      verify(mockEditProfileRepoImpl.getProfile()).called(1);
    });
  });
}
