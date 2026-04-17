import 'package:freezed_annotation/freezed_annotation.dart';
part 'reset_password_request_model.g.dart';

@JsonSerializable()
class ResetPasswordRequestModel {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'newPassword')
  final String newPassword;

  const ResetPasswordRequestModel({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordRequestModelToJson(this);
}
