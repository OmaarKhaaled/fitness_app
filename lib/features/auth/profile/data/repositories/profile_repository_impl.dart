import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/cache_modules/secure_storege_module.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/features/auth/profile/data/data_source/profile_data_source.dart';
import 'package:fitness_app/features/auth/profile/domain/entities/profile_entity.dart';
import 'package:fitness_app/features/auth/profile/domain/repositories/user_profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserProfileRepository)
class ProfileRepositoryImpl implements UserProfileRepository {
  final ProfileDataSource _profileDataSource;
  final SecureStorageService _secureStorageService;

  ProfileRepositoryImpl(this._profileDataSource, this._secureStorageService);
  @override
  Future<BaseResponse<ProfileEntity>> getLoggedUserProfile() async {
    final response = await _profileDataSource.getLoggedUserProfile();
    return response.when(
      success: (data) {
        return BaseResponse<ProfileEntity>.success(data.toEntity());
      },
      failure: (failure) {
        return BaseResponse<ProfileEntity>.failure(failure);
      },
      initial: () {
        return const BaseResponse<ProfileEntity>.initial();
      },
      loading: () {
        return const BaseResponse<ProfileEntity>.loading();
      },
    );
  }

  @override
  Future<BaseResponse<void>> logout() async {
    final response = await _profileDataSource.logout();
    return response.when(
      success: (data) async {
        await _secureStorageService.clearAuthTokens();
        await _secureStorageService.writeBool(StorageKeys.isLoggedIn, false);
        return BaseResponse<void>.success(data);
      },
      failure: (failure) {
        return BaseResponse<void>.failure(failure);
      },
      initial: () {
        return const BaseResponse<void>.initial();
      },
      loading: () {
        return const BaseResponse<void>.loading();
      },
    );
  }
}
