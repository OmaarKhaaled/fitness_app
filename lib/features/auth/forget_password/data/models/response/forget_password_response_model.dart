import 'package:freezed_annotation/freezed_annotation.dart';
part 'forget_password_response_model.g.dart';

@JsonSerializable()
class ForgetPasswordResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'info')
  final String info;

  ForgetPasswordResponseModel({required this.message, required this.info});

  factory ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseModelFromJson(json);
}
