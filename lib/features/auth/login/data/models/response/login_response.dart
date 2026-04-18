import 'package:fitness_app/features/auth/login/data/models/response/user_model.dart';
import 'package:fitness_app/features/auth/login/domain/models/login_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final User? user;
  @JsonKey(name: "token")
  final String? token;

  LoginResponse({this.message, this.user, this.token});

  LoginResponse copyWith({String? message, User? user, String? token}) =>
      LoginResponse(
        message: message ?? this.message,
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  LoginModel toModel() {
    return LoginModel(message: message ?? '', token: token ?? '');
  }
}
