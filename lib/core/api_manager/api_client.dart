import 'package:dio/dio.dart';
import 'package:fitness_app/core/constants/api_constants.dart';
import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/login/data/models/response/login_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
@singleton
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(ApiConstants.loginEndpoint)
  Future<LoginResponse> login(@Body() LoginRequest request);
}
