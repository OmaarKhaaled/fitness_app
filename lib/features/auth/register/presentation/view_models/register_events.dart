import 'package:fitness_app/features/auth/register/domain/models/register_request_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';

sealed class RegisterEvents {}

class RegisterEvent extends RegisterEvents {
  final RegisterRequestModel request;
  RegisterEvent(this.request);
}

class TogglePasswordHiddenEvent extends RegisterEvents {}

class ToggleRePasswordHiddenEvent extends RegisterEvents {}

class UpdateRegistrationDataEvent extends RegisterEvents {
  final RegisterationDataModel updatedData;
  UpdateRegistrationDataEvent(this.updatedData);
}

class NextPageEvent extends RegisterEvents {}

class PreviousPageEvent extends RegisterEvents {}

class SubmitRegistrationEvent extends RegisterEvents {}

class SelectGenderEvent extends RegisterEvents {
  final String gender;
  SelectGenderEvent(this.gender);
}

class SelectAgeEvent extends RegisterEvents {
  final int age;
  SelectAgeEvent(this.age);
}

class CacheRegistrationDataEvent extends RegisterEvents {
  final RegisterationDataModel data;
  CacheRegistrationDataEvent(this.data);
}

class SelectWeightEvent extends RegisterEvents {
  final int weight;
  SelectWeightEvent(this.weight);
}

class SelectHeightEvent extends RegisterEvents {
  final int height;
  SelectHeightEvent(this.height);
}

class SelectGoalEvent extends RegisterEvents {
  final String goal;
  SelectGoalEvent(this.goal);
}

class SelectActivityLevelEvent extends RegisterEvents {
  final String activityLevel;
  SelectActivityLevelEvent(this.activityLevel);
}
class ClearCachedDataEvent extends RegisterEvents {}