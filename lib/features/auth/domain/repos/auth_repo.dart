import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/domain/models/login_model.dart';

abstract class AuthRepo {
  Future<BaseResponse<LoginModel>> login(LoginRequest request);
}