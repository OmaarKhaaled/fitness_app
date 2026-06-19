import 'package:fitness_app/features/edit_profile/data/models/edit_profile_request_dto.dart';

class EditProfileRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  int? weight;
  String? goal;
  String? activityLevel;
  EditProfileRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.weight,
    this.goal,
    this.activityLevel,
  });
  EditProfileRequestDto toDTO() {
    return EditProfileRequestDto(
      firstName: firstName,
      lastName: lastName,
      email: email,
      weight: weight,
      goal: goal,
      activityLevel: activityLevel,
    );
  }
}
