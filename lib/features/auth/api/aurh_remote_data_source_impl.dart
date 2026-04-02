import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/api_manager/api_client.dart';
import 'package:fitness_app/features/auth/data/aurh_remote_data_source.dart';
import 'package:fitness_app/features/auth/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/data/models/response/login_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AurhRemoteDataSource)
class AurhRemoteDataSourceImpl implements AurhRemoteDataSource {
  final ApiClient _apiClient;
  AurhRemoteDataSourceImpl(this._apiClient);

@override
  Future<BaseResponse<LoginResponse>> login(LoginRequest request) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
