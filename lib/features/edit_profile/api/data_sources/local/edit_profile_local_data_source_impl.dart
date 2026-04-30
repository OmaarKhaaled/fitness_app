import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/cache_modules/secure_storege_module.dart';
import 'package:fitness_app/features/edit_profile/data/data_sources/local/edit_profile_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: EditProfileLocalDataSourceContract)
class EditProfileLocalDataSourceImpl implements EditProfileLocalDataSourceContract{
  final SecureStorageService _service;
  EditProfileLocalDataSourceImpl(this._service);
  @override
  Future<BaseResponse<bool>> saveFirstName(String key, String value) async{
    return await _service.write(key, value);
  }

  @override
  Future<BaseResponse<bool>> savePhoto(String key, String value) async{
    return await _service.write(key, value);
  }

}