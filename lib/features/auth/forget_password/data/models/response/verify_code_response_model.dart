import 'package:freezed_annotation/freezed_annotation.dart';
part 'verify_code_response_model.g.dart';

@JsonSerializable()
class VerifyCodeResponseModel {
  @JsonKey(name: 'status')
  final String status;

  VerifyCodeResponseModel({required this.status});

  factory VerifyCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyCodeResponseModel(status: json['status']);
  }
}
