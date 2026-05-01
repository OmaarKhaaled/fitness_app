import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/profile/domain/repositories/user_profile_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase {
  final UserProfileRepository _repository;
  LogoutUseCase(this._repository);

  Future<BaseResponse<void>> call() => _repository.logout();
}
