import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/exception_handler.dart';
import 'package:fitness_app/features/edit_profile/domain/use_cases/save_first_name_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

void main() {
  late SaveFirstNameUseCase firstNameUseCase;
  late MockEditProfileRepoImpl mockEditProfileRepoImpl;
  setUp(() {
    mockEditProfileRepoImpl = MockEditProfileRepoImpl();
    firstNameUseCase = SaveFirstNameUseCase(mockEditProfileRepoImpl);
  });
  group('SaveFirstNameUseCase test cases', () {
    test('success case with success response', () async {
      const key = 'user_first_name';
      const value = 'Ahmed';
      const dummyResponse = BaseResponse<bool>.success(true);

      when(
        mockEditProfileRepoImpl.saveFirstName(key, value),
      ).thenAnswer((_) async => dummyResponse);

      final result = await firstNameUseCase.call(key, value);

      expect(result, isA<BaseResponse<bool>>());
      expect(result, dummyResponse);
      verify(mockEditProfileRepoImpl.saveFirstName(key, value)).called(1);
    });
    test('error case with error response', () async {
      const key = 'user_first_name';
      const value = 'Ahmed';
      final dummyException = ExceptionsHandler.handle(
        Exception('Storage Error'),
      );
      final dummyResponse = BaseResponse<bool>.failure(dummyException);
      when(
        mockEditProfileRepoImpl.saveFirstName(key, value),
      ).thenAnswer((_) async => dummyResponse);
      final result = await firstNameUseCase.call(key, value);
      expect(result, isA<BaseResponse<bool>>());
      expect(
        result.mapOrNull(failure: (value) => value.exception),
        equals(dummyException),
      );
      verify(mockEditProfileRepoImpl.saveFirstName(key, value)).called(1);
    });
  });
}
