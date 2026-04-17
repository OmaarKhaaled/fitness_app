import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/forget_password/data/data_sources/forget_password_data_source.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordDataSource _dataSource;

  ForgetPasswordRepositoryImpl(this._dataSource);

  @override
  Future<BaseResponse<void>> forgetPassword(
    ForgetPasswordRequestModel request,
  ) async {
    final result = await _dataSource.forgetPassword(request);
    return result.when(
      success: (_) => const BaseResponse.success(null),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }

  @override
  Future<BaseResponse<void>> verifyCode(VerifyCodeRequestModel request) async {
    final result = await _dataSource.verifyCode(request);
    return result.when(
      success: (_) => const BaseResponse.success(null),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }

  @override
  Future<BaseResponse<void>> resetPassword(
    ResetPasswordRequestModel request,
  ) async {
    final result = await _dataSource.resetPassword(request);
    return result.when(
      success: (_) => const BaseResponse.success(null),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }
}
