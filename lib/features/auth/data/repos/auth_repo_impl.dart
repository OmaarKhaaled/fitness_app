import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/data/aurh_remote_data_source.dart';
import 'package:fitness_app/features/auth/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/domain/models/login_model.dart';
import 'package:fitness_app/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AurhRemoteDataSource _authRemoteDataSource;
  AuthRepoImpl(this._authRemoteDataSource);

  @override
  Future<BaseResponse<LoginModel>> login(LoginRequest request) async {
    final response = await _authRemoteDataSource.login(request);
    return response.when(
      success: (data) => BaseResponse.success(data.toModel()),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }
}
