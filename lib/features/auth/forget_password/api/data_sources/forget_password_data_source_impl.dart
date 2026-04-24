import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/features/auth/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:fitness_app/features/auth/forget_password/data/data_sources/forget_password_data_source.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/verify_code_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPasswordDataSource)
class ForgetPasswordDataSourceImpl implements ForgetPasswordDataSource {
  final ForgetPasswordApiClient _apiClient;

  ForgetPasswordDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<ForgetPasswordResponseModel>> forgetPassword(
    ForgetPasswordRequestModel request,
  ) {
    return apiCall(() async {
      return await _apiClient.forgetPassword(request);
    });
  }

  @override
  Future<BaseResponse<ResetPasswordResponseModel>> resetPassword(
    ResetPasswordRequestModel request,
  ) {
    return apiCall(() async {
      return await _apiClient.resetPassword(request);
    });
  }

  @override
  Future<BaseResponse<VerifyCodeResponseModel>> verifyCode(
    VerifyCodeRequestModel request,
  ) {
    return apiCall(() async {
      return await _apiClient.verifyCode(request);
    });
  }
}
