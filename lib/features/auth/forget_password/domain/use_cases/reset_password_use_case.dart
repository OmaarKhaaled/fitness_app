import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPasswordUseCase {
  final ForgetPasswordRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<BaseResponse<void>> call(ResetPasswordRequestModel request) {
    return _repository.resetPassword(request);
  }
}
