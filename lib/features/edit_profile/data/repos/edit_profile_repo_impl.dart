import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/edit_profile/data/data_sources/remote/edit_profile_remote_data_source_contract.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/repos/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: EditProfileRepoContract)
class EditProfileRepoImpl implements EditProfileRepoContract{
  final EditProfileRemoteDataSourceContract _dataSourceContract;
  EditProfileRepoImpl(this._dataSourceContract);
  @override
  Future<BaseResponse<EditProfileResponseModel>> editProfile(EditProfileRequestModel request) async{
    final response=await _dataSourceContract.editProfile(request.toDTO());
    return response.when(
      initial: () => const BaseResponse.initial(), 
      loading: () => const BaseResponse.loading(), 
      success: (data) => BaseResponse<EditProfileResponseModel>.success(data.toDomain()), 
      failure: (exception) => BaseResponse<EditProfileResponseModel>.failure(exception),
    );
  }
}