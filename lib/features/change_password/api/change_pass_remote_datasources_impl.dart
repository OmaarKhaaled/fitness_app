import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/core/api_manager/api_client.dart';
import 'package:fitness_app/features/change_password/data/data_sources/change_pass_remote_datasources.dart';
import 'package:fitness_app/features/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/change_password/data/models/response/change_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRemoteDataSource)
class ChangePassRemoteDatasourcesImpl
    implements ChangePasswordRemoteDataSource {
  final ApiClient apiClient;

  ChangePassRemoteDatasourcesImpl({required this.apiClient});

  @override
  Future<BaseResponse<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest changepasswordrequest,
  ) {
    return apiCall(() => apiClient.changePassword(request: changepasswordrequest));
  }
}
