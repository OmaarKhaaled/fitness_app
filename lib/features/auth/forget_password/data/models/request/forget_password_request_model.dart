import 'package:freezed_annotation/freezed_annotation.dart';
part 'forget_password_request_model.g.dart';

@JsonSerializable()
class ForgetPasswordRequestModel {
  @JsonKey(name: 'email')
  final String email;

  ForgetPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestModelToJson(this);
}
