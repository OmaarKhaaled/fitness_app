import 'package:freezed_annotation/freezed_annotation.dart';
part 'verify_code_request_model.g.dart';

@JsonSerializable()
class VerifyCodeRequestModel {
  @JsonKey(name: 'resetCode')
  final String resetCode;

  VerifyCodeRequestModel({required this.resetCode});

  Map<String, dynamic> toJson() => {'resetCode': resetCode};
}
