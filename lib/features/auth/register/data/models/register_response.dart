import 'package:fitness_app/features/auth/register/data/models/user_dto.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
    @JsonKey(name: 'message')
    String? message;
    @JsonKey(name: 'user')
    UserDTO? user;
    @JsonKey(name: 'token')
    String? token;

    RegisterResponse({
        this.message,
        this.user,
        this.token,
    });

    factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

    Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
    RegisterResponseModel toDomain(){
      return RegisterResponseModel(
        message: message,
        user: user?.toDomain(),
        token: token
      );
    }
}