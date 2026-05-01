import 'package:fitness_app/config/base_response/base_response.dart';

abstract interface class SmartCoachRemoteDataSource {
  Future<BaseResponse<String>> sendMessage(String userMessage);
}
