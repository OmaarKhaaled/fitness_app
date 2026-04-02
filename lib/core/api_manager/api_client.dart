import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/constants/api_constants.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/auth/data/models/request/login_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

abstract class ApiClient {
@POST(ApiConstants.loginEndpoint)
 Future<HttpResponse>login(@Body() LoginRequest request);
}