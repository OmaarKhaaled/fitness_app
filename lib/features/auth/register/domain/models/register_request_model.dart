import 'package:fitness_app/features/auth/register/data/models/register_request_dto.dart';

class RegisterRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? rePassword;
  String? gender;
  int? height;
  int? weight;
  int? age;
  String? goal;
  String? activityLevel;
  RegisterRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
    this.height,
    this.weight,
    this.age,
    this.goal,
    this.activityLevel
  });
  RegisterRequestDto toDTO(){
    return RegisterRequestDto(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender,
      height: height,
      weight: weight,
      age: age,
      goal: goal,
      activityLevel: activityLevel
    );
  }
}