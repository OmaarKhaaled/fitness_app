import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';

abstract class EditProfileRepoContract {
  Future<BaseResponse<EditProfileResponseModel>> editProfile(EditProfileRequestModel request);
}