import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/login/data/data_source/login_local_data_source.dart';
import 'package:fitness_app/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/login/domain/models/login_model.dart';
import 'package:fitness_app/features/auth/login/domain/repos/login_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  final LoginRemoteDataSource _authRemoteDataSource;
  final LoginLocalDataSource _authLocalDataSource;
  LoginRepoImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<BaseResponse<LoginModel>> login(LoginRequest request) async {
    final response = await _authRemoteDataSource.login(request);
    return response.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (data) {
        _authLocalDataSource.saveUserData(
          firstName: data.user?.firstName ?? '',
          imageUrl: data.user?.photo ?? '',
        );
        return BaseResponse.success(data.toModel());
      },
      failure: (exception) => BaseResponse.failure(exception),
    );
  }
}
