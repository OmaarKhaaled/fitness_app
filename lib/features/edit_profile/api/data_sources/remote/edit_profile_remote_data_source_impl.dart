import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:fitness_app/features/edit_profile/data/data_sources/remote/edit_profile_remote_data_source_contract.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile_request_dto.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: EditProfileRemoteDataSourceContract)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSourceContract{
  final EditProfileApiClient _apiClient;
  EditProfileRemoteDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<EditProfileResponse>> editProfile(EditProfileRequestDto request) async{
    return await apiCall(() => _apiClient.editProfile(request),);
  }
}