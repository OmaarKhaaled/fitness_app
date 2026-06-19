import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';

abstract class ForgetPasswordRepository {
  Future<BaseResponse<void>> forgetPassword(ForgetPasswordRequestModel request);

  Future<BaseResponse<void>> verifyCode(VerifyCodeRequestModel request);

  Future<BaseResponse<void>> resetPassword(ResetPasswordRequestModel request);
}
