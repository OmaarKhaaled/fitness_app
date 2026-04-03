import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/domain/models/login_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_states.freezed.dart';

@freezed
abstract class LoginStates with _$LoginStates {
  const factory LoginStates({
    @Default(BaseResponse.initial()) BaseResponse<LoginModel> loginResource,
    @Default(false) bool rememberMe,
  }) = _LoginStates;

  factory LoginStates.initial() => const LoginStates();
}
