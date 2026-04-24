import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';

class RegisterationDataModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  String? gender;
  int? age;
  int? height;
  int? weight;
  String? goal;
  String? activityLevel;
  RegisterationDataModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
  });
  RegisterRequestModel toRegisterRequest() {
    return RegisterRequestModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      goal: goal,
      activityLevel: activityLevel,
    );
  }

  RegisterationDataModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activityLevel,
  }) {
    return RegisterationDataModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }
}
