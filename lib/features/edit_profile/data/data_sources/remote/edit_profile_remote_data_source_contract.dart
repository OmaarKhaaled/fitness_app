import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile_request_dto.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile_response.dart';

abstract class EditProfileRemoteDataSourceContract {
  Future<BaseResponse<EditProfileResponse>> editProfile(EditProfileRequestDto request); 
}