import 'package:dio/dio.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/api_manager/api_client.dart';
import 'package:fitness_app/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/login/data/models/response/login_response.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness_app/config/errors/app_exception.dart';

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiClient _apiClient;
  LoginRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _apiClient.login(request);

      return BaseResponse.success(response);
    } on DioException catch (e) {
      final String? errorMessage = e.response?.data is Map
          ? (e.response?.data['error'] ?? e.response?.data['message'])
          : null;

      return BaseResponse.failure(
        AppException(
          errorMessage ?? e.message ?? 'An unexpected error occurred',
        ),
      );
    } catch (e) {
      return BaseResponse.failure(AppException(e.toString()));
    }
  }
}
