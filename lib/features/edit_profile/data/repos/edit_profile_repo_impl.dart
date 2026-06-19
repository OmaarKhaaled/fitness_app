import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/edit_profile/data/data_sources/local/edit_profile_local_data_source_contract.dart';
import 'package:fitness_app/features/edit_profile/data/data_sources/remote/edit_profile_remote_data_source_contract.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/upload_photo_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/repos/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepoContract)
class EditProfileRepoImpl implements EditProfileRepoContract {
  final EditProfileRemoteDataSourceContract _dataSourceContract;
  final EditProfileLocalDataSourceContract _localDataSourceContract;
  EditProfileRepoImpl(this._dataSourceContract, this._localDataSourceContract);
  @override
  Future<BaseResponse<EditProfileResponseModel>> editProfile(
    EditProfileRequestModel request,
  ) async {
    final response = await _dataSourceContract.editProfile(request.toDTO());
    return response.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (data) =>
          BaseResponse<EditProfileResponseModel>.success(data.toDomain()),
      failure: (exception) =>
          BaseResponse<EditProfileResponseModel>.failure(exception),
    );
  }

  @override
  Future<BaseResponse<EditProfileResponseModel>> getProfile() async {
    final response = await _dataSourceContract.getProfile();
    return response.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (data) =>
          BaseResponse<EditProfileResponseModel>.success(data.toDomain()),
      failure: (exception) =>
          BaseResponse<EditProfileResponseModel>.failure(exception),
    );
  }

  @override
  Future<BaseResponse<UploadPhotoResponseModel>> uploadPhoto(File photo) async {
    final response = await _dataSourceContract.uploadPhoto(photo);
    return response.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (data) =>
          BaseResponse<UploadPhotoResponseModel>.success(data.toDomain()),
      failure: (exception) =>
          BaseResponse<UploadPhotoResponseModel>.failure(exception),
    );
  }

  @override
  Future<BaseResponse<bool>> saveFirstName(String key, String value) async {
    return await _localDataSourceContract.saveFirstName(key, value);
  }

  @override
  Future<BaseResponse<bool>> savePhoto(String key, String value) async {
    return await _localDataSourceContract.savePhoto(key, value);
  }
}
