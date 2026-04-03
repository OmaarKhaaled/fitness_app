import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/data/models/response/login_response.dart';
import 'package:fitness_app/features/auth/domain/models/login_model.dart';
import 'package:fitness_app/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;
  LoginUseCase(this._authRepo);

  Future<BaseResponse<LoginModel>> call(LoginRequest request) async {
    return await _authRepo.login(request);
  }
}
