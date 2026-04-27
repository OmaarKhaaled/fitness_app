import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/cache_modules/secure_storege_module.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/features/smart_coach/data/datasources/local/smart_coach_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SmartCoachLocalDataSource)
class SmartCoachLocalDataSourceImpl implements SmartCoachLocalDataSource {
  final SecureStorageService _secureStorageService;
  SmartCoachLocalDataSourceImpl(this._secureStorageService);
  @override
  Future<BaseResponse<String?>> getFirstName() async {
    return await _secureStorageService.read(CacheConstants.firstName);
  }
}
