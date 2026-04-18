import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/login/data/models/response/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<BaseResponse<LoginResponse>> login(LoginRequest request);
}