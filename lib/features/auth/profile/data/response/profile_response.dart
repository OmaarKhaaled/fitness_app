import 'package:fitness_app/features/auth/profile/data/response/user.dart';
import 'package:fitness_app/features/auth/profile/domain/entities/profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'user')
  final User? user;

  ProfileResponse({this.message, this.user});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

  ProfileEntity toEntity() => ProfileEntity(
    firstName: user?.firstName ?? '',
    lastName: user?.lastName ?? '',
    photo: user?.photo,
  );
}
