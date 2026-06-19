import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/auth/change_password/data/models/response/change_password_response.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<BaseResponse<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest changepasswordrequest,
  );
}
