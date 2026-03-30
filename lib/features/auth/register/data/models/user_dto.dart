import 'package:fitness_app/features/auth/register/domain/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';
@JsonSerializable()
class UserDTO {
    @JsonKey(name: 'firstName')
    String? firstName;
    @JsonKey(name: 'lastName')
    String? lastName;
    @JsonKey(name: 'email')
    String? email;
    @JsonKey(name: 'gender')
    String? gender;
    @JsonKey(name: 'age')
    int? age;
    @JsonKey(name: 'weight')
    int? weight;
    @JsonKey(name: 'height')
    int? height;
    @JsonKey(name: 'activityLevel')
    String? activityLevel;
    @JsonKey(name: 'goal')
    String? goal;
    @JsonKey(name: 'photo')
    String? photo;
    @JsonKey(name: '_id')
    String? id;
    @JsonKey(name: 'createdAt')
    DateTime? createdAt;

    UserDTO({
        this.firstName,
        this.lastName,
        this.email,
        this.gender,
        this.age,
        this.weight,
        this.height,
        this.activityLevel,
        this.goal,
        this.photo,
        this.id,
        this.createdAt,
    });

    factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);

    Map<String, dynamic> toJson() => _$UserDTOToJson(this);
    UserModel toDomain(){
      return UserModel(
        firstName: firstName,
        lastName: lastName
      );
    }
}