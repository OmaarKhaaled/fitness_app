import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/edit_profile/domain/repos/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavePhotoUseCase {
  final EditProfileRepoContract _repoContract;
  SavePhotoUseCase(this._repoContract);
  Future<BaseResponse<bool>> call(String key,String value)async{
    return _repoContract.savePhoto(key, value);
  }
}