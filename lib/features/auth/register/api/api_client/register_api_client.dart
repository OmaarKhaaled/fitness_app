import 'package:dio/dio.dart';
import 'package:fitness_app/core/constants/api_constants.dart';
import 'package:fitness_app/features/auth/register/data/models/register_request_dto.dart';
import 'package:fitness_app/features/auth/register/data/models/register_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'register_api_client.g.dart';

@injectable
@RestApi()
abstract class RegisterApiClient {
  @factoryMethod
  factory RegisterApiClient(Dio dio) = _RegisterApiClient;
  @POST(ApiConstants.registerEndpoint)
  Future<RegisterResponse> register(@Body() RegisterRequestDto registerRequest);
}
