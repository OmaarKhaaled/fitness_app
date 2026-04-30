import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/change_password/domain/models/change_password_model.dart';

abstract class ChangePasswordRepo {
  Future<BaseResponse<ChangePasswordModel>> changePassword(ChangePasswordRequest changepasswordrequest);
}
