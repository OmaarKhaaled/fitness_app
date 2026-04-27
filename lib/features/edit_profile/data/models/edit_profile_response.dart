import 'package:fitness_app/features/edit_profile/data/models/user_dto.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'edit_profile_response.g.dart';

@JsonSerializable()
class EditProfileResponse {
    @JsonKey(name: 'message')
    String? message;
    @JsonKey(name: 'user')
    UserDTO? user;

    EditProfileResponse({
        this.message,
        this.user,
    });

    factory EditProfileResponse.fromJson(Map<String, dynamic> json) => _$EditProfileResponseFromJson(json);

    Map<String, dynamic> toJson() => _$EditProfileResponseToJson(this);
    EditProfileResponseModel toDomain(){
      return EditProfileResponseModel(
        message: message,
        userModel: user?.toDomain()
      );
    }
}