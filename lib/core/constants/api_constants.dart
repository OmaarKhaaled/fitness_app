class ApiConstants {
  //------------------------------- Base URL -----------------------------------//
  static const String baseUrl = 'https://fitness.elevateegy.com/api/v1/';

  //------------------------------- Auth Endpoints -----------------------------//
  static const String loginEndpoint = 'auth/signin';
  static const String registerEndpoint = 'auth/signup';
  static const String changePasswordEndpoint = 'auth/change-password';
  static const String uploadPhotoEndpoint = 'auth/upload-photo';
  static const String getLoggedUserDataEndpoint = 'auth/profile-data';
  static const String logoutEndpoint = 'auth/logout';
  static const String forgotPasswordEndpoint = 'auth/forgotPassword';
  static const String verifyResetCodeEndpoint = 'auth/verifyResetCode';
  static const String resetPasswordEndpoint = 'auth/resetPassword';
  static const String deleteMeEndpoint = 'auth/deleteMe';
  static const String editProfileEndpoint = 'auth/editProfile';

  //------------------------------- levels Endpoints ---------------------------//
  static const String getDifficultyLevelsByPrimeMoverEndpoint =
      'levels/difficulty-levels/by-prime-mover';
  static const String getAllDifficultyLevels = 'levels';

  //------------------------------- muscles Endpoints -------------------------//
  static const String getAllMuscleGroupsEndpoint = 'muscles';
  static const String getAllMuscleGroupByMuscleIdEndpoint =
      'musclesGroup/{MuscleGroupId}';
  static const String getRandomPrimeMoverMusclesEndpoint = 'muscles/random';

  //------------------------------- exercises Endpoints -----------------------//
  static const String exercisesByPrimeMoverMuscleAndDifficultyLevel =
      'exercises/by-muscle-difficulty';
<<<<<<< HEAD

  static const String getRandomMuscleEndpoint = 'muscles/random';
  static const String getMuscleGroupByMuscleIdEndpoint =
      'musclesGroup/by-muscle-group?muscleGroupId={MuscleGroupId}';
=======
>>>>>>> a812930 (feat: implement exercise feature with screen, navigation, cubit state management, and repository integration)
}
