import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/profile/data/response/profile_response.dart';

abstract interface class ProfileDataSource {
  Future<BaseResponse<ProfileResponse>> getLoggedUserProfile();
  Future<BaseResponse<void>> logout();
}
