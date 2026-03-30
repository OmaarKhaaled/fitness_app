import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/data/models/register_request_dto.dart';
import 'package:fitness_app/features/auth/register/data/models/register_response.dart';

abstract class RegisterRemoteDataSourceContract {
  Future<BaseResponse<RegisterResponse>> register(RegisterRequestDto request);
}