import 'dart:async';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/features/change_password/data/data_sources/change_pass_remote_datasources.dart';
import 'package:fitness_app/features/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/change_password/domain/models/change_pass_model.dart';
import 'package:fitness_app/features/change_password/domain/repos/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePassRepoImpl implements ChangePasswordRepo {
  ChangePasswordRemoteDataSource _changePasswordRemoteDataSource;
  ChangePassRepoImpl(this._changePasswordRemoteDataSource);

  @override
  Future<BaseResponse<ChangePasswordModel>> changePassword(
    ChangePasswordRequest changePasswordRequest,
  ) async {
    final response = await _changePasswordRemoteDataSource.changePassword(changePasswordRequest);
    return response.when(
      initial: () => const BaseResponse.initial(),
      loading: () => const BaseResponse.loading(),
      success: (data) => BaseResponse.success(
        ChangePasswordModel(
          message: data.message ?? '',
          token: data.token,
        ),
      ),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }
}
