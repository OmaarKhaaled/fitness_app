import 'package:fitness_app/config/base_response/base_response.dart';

abstract interface class SmartCoachLocalDataSource {
  Future<BaseResponse<String?>> getFirstName();
  Future<BaseResponse<String?>> getImageUrl();
}
