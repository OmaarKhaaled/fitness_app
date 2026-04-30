import 'package:fitness_app/config/base_response/base_response.dart';

abstract class EditProfileLocalDataSourceContract {
  Future<BaseResponse<bool>> saveFirstName(String key,String value);
  Future<BaseResponse<bool>> savePhoto(String key,String value);
}