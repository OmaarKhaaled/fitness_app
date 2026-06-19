import 'dart:io';

import 'package:fitness_app/features/edit_profile/domain/models/edit_profile_request_model.dart';

sealed class EditProfileEvents {}

class EditProfileEvent extends EditProfileEvents {
  EditProfileRequestModel requestModel;
  EditProfileEvent(this.requestModel);
}

class GetProfileEvent extends EditProfileEvents {}

class ResetEditSuccessEvent extends EditProfileEvents {}

class UploadPhotoEvent extends EditProfileEvents {
  final File photo;
  UploadPhotoEvent(this.photo);
}

class UpdateWeightEvent extends EditProfileEvents {
  final int weight;
  UpdateWeightEvent(this.weight);
}

class UpdateWeightIndexEvent extends EditProfileEvents {
  final int index;
  final int weight;
  UpdateWeightIndexEvent(this.index, this.weight);
}

class UpdateGoalEvent extends EditProfileEvents {
  final String goal;
  UpdateGoalEvent(this.goal);
}

class SelectGoalEvent extends EditProfileEvents {
  final String goal;
  SelectGoalEvent(this.goal);
}

class SelectActivityLevelEvent extends EditProfileEvents {
  final String activityLevel;
  SelectActivityLevelEvent(this.activityLevel);
}

class UpdateActivityLevelEvent extends EditProfileEvents {
  final String activityLevel;
  UpdateActivityLevelEvent(this.activityLevel);
}

class SaveFirstNameEvent extends EditProfileEvents {
  final String key;
  final String value;
  SaveFirstNameEvent(this.key, this.value);
}

class SavePhotoEvent extends EditProfileEvents {
  final String key;
  final String value;
  SavePhotoEvent(this.key, this.value);
}
class UpdateFirstNameEvent extends EditProfileEvents {
  final String firstName;
  UpdateFirstNameEvent(this.firstName);
}

class UpdateLastNameEvent extends EditProfileEvents {
  final String lastName;
  UpdateLastNameEvent(this.lastName);
}

class UpdateEmailEvent extends EditProfileEvents {
  final String email;
  UpdateEmailEvent(this.email);
}