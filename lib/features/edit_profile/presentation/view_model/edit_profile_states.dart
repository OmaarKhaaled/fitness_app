import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_response_model.dart';
import 'package:fitness_app/features/edit_profile/domain/models/upload_photo_response_model.dart';

class EditProfileStates {
  BaseState<EditProfileResponseModel>? profileState;
  BaseState<EditProfileResponseModel>? editProfileState;
  bool isEditSuccess;
  BaseState<UploadPhotoResponseModel>? uploadState;
  int currentWeightIndex;  
  int selectedWeight;
  String? selectedGoal;
  String? selectedActivityLevel;   
  EditProfileStates({
    this.profileState,
    this.editProfileState,
    this.isEditSuccess=false,
    this.uploadState,
    this.currentWeightIndex=45,
    this.selectedWeight=90,
    this.selectedGoal,
    this.selectedActivityLevel
  });
  EditProfileStates copyWith(
    {
      BaseState<EditProfileResponseModel>? profileState,
      BaseState<EditProfileResponseModel>? editProfileState,
      bool? isEditSuccess,
      BaseState<UploadPhotoResponseModel>? uploadState,
      int? currentWeightIndex,
      int? selectedWeight,
      String? selectedGoal,
      String? selectedActivityLevel
    }
  ){
    return EditProfileStates(
      profileState: profileState ?? this.profileState,
      editProfileState: editProfileState ?? this.editProfileState,
      isEditSuccess: isEditSuccess ?? this.isEditSuccess,
      uploadState: uploadState ?? this.uploadState,
      currentWeightIndex: currentWeightIndex ?? this.currentWeightIndex,
      selectedWeight: selectedWeight ?? this.selectedWeight,
      selectedGoal: selectedGoal ?? this.selectedGoal,
      selectedActivityLevel: selectedActivityLevel ?? this.selectedActivityLevel
    );
  }
}