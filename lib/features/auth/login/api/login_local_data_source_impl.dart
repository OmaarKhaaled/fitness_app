import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/cache_modules/secure_storege_module.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/features/auth/login/data/data_source/login_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SecureStorageService _secureStorageService;
  LoginLocalDataSourceImpl(this._secureStorageService);
  @override
  Future<BaseResponse<void>> saveUserData({
    required String firstName,
    required String imageUrl,
  }) async {
    final response = await _secureStorageService.write(
      CacheConstants.firstName,
      firstName,
    );
    final response2 = await _secureStorageService.write(
      CacheConstants.imageUrl,
      imageUrl,
    );
    return response.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (s) {
        return response2.when(
          initial: () => const BaseResponse.initial(),
          loading: () => const BaseResponse.loading(),
          success: (s) => const BaseResponse.success(null),
          failure: (f) => BaseResponse.failure(f),
        );
      },
      failure: (f) => BaseResponse.failure(f),
    );
  }
}
