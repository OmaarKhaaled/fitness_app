import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/upload_photo_response_model.dart';

abstract class EditProfileRepoContract {
  Future<BaseResponse<EditProfileResponseModel>> editProfile(
    EditProfileRequestModel request,
  );
  Future<BaseResponse<EditProfileResponseModel>> getProfile();
  Future<BaseResponse<UploadPhotoResponseModel>> uploadPhoto(File photo);
  Future<BaseResponse<bool>> saveFirstName(String key, String value);
  Future<BaseResponse<bool>> savePhoto(String key, String value);
}
