import 'package:freezed_annotation/freezed_annotation.dart';
part 'reset_password_response_model.g.dart';

@JsonSerializable()
class ResetPasswordResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'token')
  final String token;

  const ResetPasswordResponseModel({
    required this.message,
    required this.token,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseModelToJson(this);
}
