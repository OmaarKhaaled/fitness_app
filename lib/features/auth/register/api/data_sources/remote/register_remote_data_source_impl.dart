import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/features/auth/register/api/api_client/register_api_client.dart';
import 'package:fitness_app/features/auth/register/data/data_sources/remote/register_remote_data_source_contract.dart';
import 'package:fitness_app/features/auth/register/data/models/register_request_dto.dart';
import 'package:fitness_app/features/auth/register/data/models/register_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRemoteDataSourceContract)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSourceContract {
  final RegisterApiClient _registerApiClient;
  RegisterRemoteDataSourceImpl(this._registerApiClient);
  @override
  Future<BaseResponse<RegisterResponse>> register(
    RegisterRequestDto request,
  ) async {
    return await apiCall(() => _registerApiClient.register(request));
  }
}
