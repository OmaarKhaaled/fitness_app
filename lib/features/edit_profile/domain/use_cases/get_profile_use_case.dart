import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/repos/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final EditProfileRepoContract _contract;
  GetProfileUseCase(this._contract);
  Future<BaseResponse<EditProfileResponseModel>> call() async {
    return _contract.getProfile();
  }
}
