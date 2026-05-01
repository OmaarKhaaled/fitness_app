import 'package:fitness_app/features/edit_profile/domain/models/user_model.dart';

class EditProfileResponseModel {
  String? message;
  UserModel? userModel;
  EditProfileResponseModel({this.message, this.userModel});
}
