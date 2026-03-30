import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_response_model.dart';
import 'package:fitness_app/features/auth/register/domain/repos/register_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final RegisterRepoContract _registerRepoContract;
  RegisterUseCase(this._registerRepoContract);
  Future<BaseResponse<RegisterResponseModel>> call(
    RegisterRequestModel request,
  ) {
    return _registerRepoContract.register(request);
  }
}
