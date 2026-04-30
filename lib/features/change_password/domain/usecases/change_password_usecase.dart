import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/change_password/data/models/request/change_password_request.dart';
import 'package:fitness_app/features/change_password/domain/models/change_password_model.dart';
import 'package:fitness_app/features/change_password/domain/repos/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUsecase {
  final ChangePasswordRepo _changePasswordRepo;
  ChangePasswordUsecase(this._changePasswordRepo);
  Future<BaseResponse<ChangePasswordModel>> call(
    ChangePasswordRequest request,
  ) async {
    return await _changePasswordRepo.changePassword(request);
  }
}
