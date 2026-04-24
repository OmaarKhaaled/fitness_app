import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyCodeUseCase {
  final ForgetPasswordRepository _repository;

  VerifyCodeUseCase(this._repository);

  Future<BaseResponse<void>> call(VerifyCodeRequestModel request) {
    return _repository.verifyCode(request);
  }
}
