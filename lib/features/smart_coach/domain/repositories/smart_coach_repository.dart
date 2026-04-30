import 'package:fitness_app/config/base_response/base_response.dart';

abstract interface class SmartCoachRepository {
  Future<BaseResponse<String?>> getFirstName();
  Future<BaseResponse<String?>> getImageUrl();
  Future<BaseResponse<String>> sendMessage(String userMessage);
}
