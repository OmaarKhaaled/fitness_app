import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/features/auth/profile/api/api_client/profile_api_client.dart';
import 'package:fitness_app/features/auth/profile/data/data_source/profile_data_source.dart';
import 'package:fitness_app/features/auth/profile/data/response/profile_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileDataSource)
class ProfileDataSourceImpl implements ProfileDataSource {
  final ProfileApiClient _apiClient;

  ProfileDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<ProfileResponse>> getLoggedUserProfile() {
    return apiCall(() => _apiClient.getLoggedUserData());
  }

  @override
  Future<BaseResponse<void>> logout() {
    return apiCall(() => _apiClient.logout());
  }
}
