import 'package:fitness_app/features/auth/login/data/models/response/user_model.dart';

class LoginModel {
  final String message;
  final String token;
  final User user;

  const LoginModel({required this.message, required this.token, required this.user});
}
