import 'package:fitness_app/features/edit_profile/data/models/edit_profile_request_dto.dart';

class EditProfileRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? photo;
  int? weight;
  String? goal;
  String? activityLevel;
  EditProfileRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.photo,
    this.weight,
    this.goal,
    this.activityLevel
  });
  EditProfileRequestDto toDTO(){
    return EditProfileRequestDto(
      firstName: firstName,
      lastName: lastName,
      email: email,
      photo: photo,
      weight: weight,
      goal: goal,
      activityLevel: activityLevel
    );
  }
}