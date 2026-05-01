import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/profile/domain/entities/profile_entity.dart';
import 'package:fitness_app/features/auth/profile/domain/repositories/user_profile_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserProfileUseCase {
  final UserProfileRepository _repository;
  GetUserProfileUseCase(this._repository);

  Future<BaseResponse<ProfileEntity>> call() =>
      _repository.getLoggedUserProfile();
}
