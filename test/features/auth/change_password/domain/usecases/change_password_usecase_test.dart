import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/features/auth/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/auth/change_password/domain/models/change_password_model.dart';
import 'package:fitness_app/features/auth/change_password/domain/repos/change_password_repo.dart';
import 'package:fitness_app/features/auth/change_password/domain/usecases/change_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'change_password_usecase_test.mocks.dart';

@GenerateMocks([ChangePasswordRepo])
void main() {
  late MockChangePasswordRepo changePasswordRepo;
  late ChangePasswordUsecase changePasswordUsecase;

  setUp(() {
    changePasswordRepo = MockChangePasswordRepo();
    changePasswordUsecase = ChangePasswordUsecase(changePasswordRepo);
    provideDummy(
      BaseResponse<ChangePasswordModel>.success(
        ChangePasswordModel(message: 'success', token: 'token'),
      ),
    );
  });
  group('ChangePasswordUseCase => call ', () {
    test('change password usecase success', () async {
      final request = ChangePasswordRequest(
        password: 'password',
        newPassword: 'newPassword',
      );
      when(changePasswordRepo.changePassword(request)).thenAnswer(
        (_) async => BaseResponse<ChangePasswordModel>.success(
          ChangePasswordModel(message: 'success', token: 'token'),
        ),
      );
      final result = await changePasswordUsecase(request);
      expect(result, isA<BaseSuccess<ChangePasswordModel>>());
    });
    test('change password usecase error', () async {
      final request = ChangePasswordRequest(
        password: 'password',
        newPassword: 'newPassword',
      );
      const exception = AppException('error');

      when(
        changePasswordRepo.changePassword(request),
      ).thenAnswer((_) async => const BaseResponse.failure(exception));
      final result = await changePasswordUsecase(request);
      expect(
        result,
        const BaseResponse<ChangePasswordModel>.failure(exception),
      );
      verify(changePasswordUsecase.call(request)).called(1);
    });
  });
}
