import 'package:json_annotation/json_annotation.dart';
part 'edit_profile_request_dto.g.dart';


@JsonSerializable()
class EditProfileRequestDto {
    @JsonKey(name: 'firstName')
    String? firstName;
    @JsonKey(name: 'lastName')
    String? lastName;
    @JsonKey(name: 'email')
    String? email;
    @JsonKey(name: 'weight')
    int? weight;
    @JsonKey(name: 'goal')
    String? goal;
    @JsonKey(name: 'activityLevel')
    String? activityLevel;

    EditProfileRequestDto({
        this.firstName,
        this.lastName,
        this.email,
        this.weight,
        this.goal,
        this.activityLevel,
    });

    factory EditProfileRequestDto.fromJson(Map<String, dynamic> json) => _$EditProfileRequestDtoFromJson(json);

    Map<String, dynamic> toJson() => _$EditProfileRequestDtoToJson(this);
}
