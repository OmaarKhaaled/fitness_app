import 'package:fitness_app/features/auth/register/domain/models/user_model.dart';

class RegisterResponseModel {
  String? message;
  UserModel? user;
  String? token;
  RegisterResponseModel({this.message,this.user,this.token});
}