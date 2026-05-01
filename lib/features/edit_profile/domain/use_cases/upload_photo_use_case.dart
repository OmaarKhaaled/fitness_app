import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/edit_profile/domain/models/upload_photo_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/repos/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final EditProfileRepoContract _repoContract;
  UploadPhotoUseCase(this._repoContract);
  Future<BaseResponse<UploadPhotoResponseModel>> call(File photo) async {
    return _repoContract.uploadPhoto(photo);
  }
}
