import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/profile/domain/entities/profile_entity.dart';

abstract interface class UserProfileRepository {
  Future<BaseResponse<ProfileEntity>> getLoggedUserProfile();
  Future<BaseResponse<void>> logout();
}
