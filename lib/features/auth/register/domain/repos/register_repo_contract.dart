import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_response_model.dart';

abstract class RegisterRepoContract {
  Future<BaseResponse<RegisterResponseModel>> register(
    RegisterRequestModel request,
  );
}
