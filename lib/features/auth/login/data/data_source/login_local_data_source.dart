import 'package:fitness_app/config/base_response/base_response.dart';

abstract interface class LoginLocalDataSource {
  Future<BaseResponse<void>> saveFirstName(String firstName);
}
