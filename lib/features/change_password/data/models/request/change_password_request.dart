import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
    @JsonKey(name: 'password')
    final String? password;
    @JsonKey(name: 'newPassword')
    final String? newPassword;

    ChangePasswordRequest({
        this.password,
        this.newPassword,
    });

    ChangePasswordRequest copyWith({
        String? password,
        String? newPassword,
    }) => 
        ChangePasswordRequest(
            password: password ?? this.password,
            newPassword: newPassword ?? this.newPassword,
        );

    factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestFromJson(json);

    Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}