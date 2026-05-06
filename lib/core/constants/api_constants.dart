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
  static const String getAllDifficultyLevelsEndpoint = 'levels';
  //------------------------------- muscles Endpoints -------------------------//
  static const String getAllMuscleGroupsEndpoint = 'muscles';
  static const String getAllMuscleGroupByMuscleIdEndpoint =
      'musclesGroup/{MuscleGroupId}';
  static const String getRandomMuscleEndpoint = 'muscles/random';
  static const String getMuscleGroupByMuscleIdEndpoint =
      'musclesGroup/by-muscle-group?muscleGroupId={MuscleGroupId}';

  //------------------------------- meals Endpoints -----------------------//
  static const String mealsDbBaseUrl =
      'https://www.themealdb.com/api/json/v1/1/';
  static const String mealsCategoriesEndpoint = 'categories.php';
  static const String getMealsByCategoryEndpoint = 'filter.php';
  static const String getMealDetailsEndpoint = 'lookup.php';
  static const String getMealDetailsEndpointQueryParam = '';
}
