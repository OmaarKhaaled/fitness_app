import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/auth/register/domain/models/register_response_model.dart';
import 'package:fitness_app/features/auth/register/domain/models/registeration_data_model.dart';

class RegisterStates {
  BaseState<RegisterResponseModel>? registerState;
  bool isPasswordHidden;
  bool isRePasswordHidden;
  int currentPageIndex;
  RegisterationDataModel registerationData;
  String? selectedGender;
  int? selectedAge;
  int selectedWeight;
  int selectedHeight;
  String? selectedGoal;
  String? selectedActivityLevel;
  RegisterationDataModel? cachedRegistrationData;
  bool isRegistrationComplete;
  RegisterStates({
    this.registerState,
    this.isPasswordHidden = true,
    this.isRePasswordHidden = true,
    this.currentPageIndex = 0,
    required this.registerationData,
    this.selectedGender,
    this.selectedAge,
    this.selectedWeight = 90,
    this.selectedHeight = 165,
    this.selectedGoal,
    this.selectedActivityLevel,
    this.cachedRegistrationData,
    this.isRegistrationComplete = false,
  });
  RegisterStates copyWith({
    BaseState<RegisterResponseModel>? registerState,
    bool? isPasswordHidden,
    bool? isRePasswordHidden,
    int? currentPageIndex,
    RegisterationDataModel? registerationData,
    String? selectedGender,
    int? selectedAge,
    int? selectedWeight,
    int? selectedHeight,
    String? selectedGoal,
    String? selectedActivityLevel,
    RegisterationDataModel? cachedRegistrationData,
    bool? isRegistrationComplete,
  }) {
    return RegisterStates(
      registerState: registerState ?? this.registerState,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isRePasswordHidden: isRePasswordHidden ?? this.isRePasswordHidden,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      registerationData: registerationData ?? this.registerationData,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedAge: selectedAge ?? this.selectedAge,
      selectedWeight: selectedWeight ?? this.selectedWeight,
      selectedHeight: selectedHeight ?? this.selectedHeight,
      selectedGoal: selectedGoal ?? this.selectedGoal,
      selectedActivityLevel:
          selectedActivityLevel ?? this.selectedActivityLevel,
      cachedRegistrationData:
          cachedRegistrationData ?? this.cachedRegistrationData,
      isRegistrationComplete:
          isRegistrationComplete ?? this.isRegistrationComplete,
    );
  }
}
