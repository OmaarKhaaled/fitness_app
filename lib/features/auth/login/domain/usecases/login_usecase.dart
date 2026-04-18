import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/login/domain/models/login_model.dart';
import 'package:fitness_app/features/auth/login/domain/repos/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepo _loginRepo;
  LoginUseCase(this._loginRepo);

  Future<BaseResponse<LoginModel>> call(LoginRequest request) async {
    return await _loginRepo.login(request);
  }
}
