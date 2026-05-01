import 'package:easy_localization/easy_localization.dart';

class AppTextConstants {
  AppTextConstants._();
  // Language Keys
  static const String enLangKey = 'en';

  static const String arLangKey = 'ar';

  // Splash
  static String get appName => 'splash.app_name'.tr();

  // Onboarding
  static List<String> get onBoardingSlideTitles => [
    'onboarding.slide1.title'.tr(),
    'onboarding.slide2.title'.tr(),
    'onboarding.slide3.title'.tr(),
  ];

  static List<String> get onBoardingSlideDescriptions => [
    'onboarding.slide1.description'.tr(),
    'onboarding.slide2.description'.tr(),
    'onboarding.slide3.description'.tr(),
  ];
  static String get onboardingNextButton => 'onboarding.buttons.next'.tr();
  static String get onboardingBackButton => 'onboarding.buttons.back'.tr();
  static String get onboardingSkipButton => 'onboarding.buttons.skip'.tr();
  static String get onboardingDoItButton => 'onboarding.buttons.do_it'.tr();

  // Login
  static String get loginGreeting => 'login.greeting'.tr();
  static String get loginWelcomeBack => 'login.welcome_back'.tr();
  static String get loginHeading => 'login.heading'.tr();
  static String get loginEmailPlaceholder => 'login.email_placeholder'.tr();
  static String get loginPasswordPlaceholder =>
      'login.password_placeholder'.tr();
  static String get loginForgotPassword => 'login.forgot_password'.tr();
  static String get loginOr => 'login.or'.tr();
  static String get loginButton => 'login.button'.tr();
  static String get loginNoAccount => 'login.no_account'.tr();
  static String get loginRegisterLink => 'login.RegisterLink'.tr();

  // Register
  static String get registerGreeting => 'register.greeting'.tr();
  static String get registerCreateAccount => 'register.create_account'.tr();
  static String get registerHeading => 'register.heading'.tr();
  static String get registerFirstNamePlaceholder =>
      'register.first_name_placeholder'.tr();
  static String get registerLastNamePlaceholder =>
      'register.last_name_placeholder'.tr();
  static String get registerEmailPlaceholder =>
      'register.email_placeholder'.tr();
  static String get registerPasswordPlaceholder =>
      'register.password_placeholder'.tr();
  static String get registerRePasswordPlaceholder =>
      'register.repassword_placeholder'.tr();
  static String get registerOr => 'register.or'.tr();
  static String get registerButton => 'register.button'.tr();
  static String get registerAlreadyAccount =>
      'register.already_have_account'.tr();
  static String get registerLoginLink => 'register.login'.tr();

  // Profile Setup
  static String get profileSetupTellUs => 'profile_setup.tell_us'.tr();
  static String get profileSetupStepIndicator =>
      'profile_setup.step_indicator'.tr();

  // Gender
  static String get profileSetupGenderSelectInstruction =>
      'profile_setup.gender.select_instruction'.tr();
  static String get profileSetupGenderMale => 'profile_setup.gender.male'.tr();
  static String get profileSetupGenderFemale =>
      'profile_setup.gender.female'.tr();
  static String get profileSetupGenderButton =>
      'profile_setup.gender.button'.tr();

  // Age
  static String get profileSetupAgeQuestion =>
      'profile_setup.age.question'.tr();
  static String get profileSetupAgeSelectionInfo =>
      'profile_setup.age.selection_info'.tr();
  static String get profileSetupAgeYear => 'profile_setup.age.year'.tr();
  static String get profileSetupAgeButton => 'profile_setup.age.button'.tr();

  // Weight
  static String get profileSetupWeightQuestion =>
      'profile_setup.weight.question'.tr();
  static String get profileSetupWeightSelectionInfo =>
      'profile_setup.weight.selection_info'.tr();
  static String get profileSetupWeightUnit => 'profile_setup.weight.unit'.tr();
  static String get profileSetupWeightButton =>
      'profile_setup.weight.button'.tr();

  // Height
  static String get profileSetupHeightQuestion =>
      'profile_setup.height.question'.tr();
  static String get profileSetupHeightSelectionInfo =>
      'profile_setup.height.selection_info'.tr();
  static String get profileSetupHeightUnit => 'profile_setup.height.unit'.tr();
  static String get profileSetupHeightButton =>
      'profile_setup.height.button'.tr();

  // Goal
  static String get profileSetupGoalQuestion =>
      'profile_setup.goal.question'.tr();
  static String get profileSetupGoalSelectionInfo =>
      'profile_setup.goal.selection_info'.tr();
  static String get profileSetupGoalGainWeight =>
      'profile_setup.goal.options.gain_weight'.tr();
  static String get profileSetupGoalLoseWeight =>
      'profile_setup.goal.options.lose_weight'.tr();
  static String get profileSetupGoalGetFitter =>
      'profile_setup.goal.options.get_fitter'.tr();
  static String get profileSetupGoalGainMoreFlexible =>
      'profile_setup.goal.options.gain_more_flexible'.tr();
  static String get profileSetupGoalLearnTheBasic =>
      'profile_setup.goal.options.learn_the_basic'.tr();
  static String get profileSetupGoalButton => 'profile_setup.goal.button'.tr();

  // Activity
  static String get profileSetupActivityQuestion =>
      'profile_setup.activity.question'.tr();
  static String get profileSetupActivityRookie =>
      'profile_setup.activity.options.rookie'.tr();
  static String get profileSetupActivityBeginner =>
      'profile_setup.activity.options.beginner'.tr();
  static String get profileSetupActivityIntermediate =>
      'profile_setup.activity.options.intermediate'.tr();
  static String get profileSetupActivityAdvance =>
      'profile_setup.activity.options.advance'.tr();
  static String get profileSetupActivityTrueBeast =>
      'profile_setup.activity.options.true_beast'.tr();
  static String get profileSetupActivityButton =>
      'profile_setup.activity.button'.tr();

  // forget password
  static String get pleaseEnterValidEmail =>
      'forget_password.please_enter_valid_email'.tr();
  static String get forgetPassword => 'forget_password.forget_password'.tr();
  static String get enterYourEmail => 'forget_password.enter_your_email'.tr();
  static String get sendOtp => 'forget_password.send_otp'.tr();
  static String get otpCode => 'forget_password.otp_code'.tr();
  static String get otpCodeDescription =>
      'forget_password.otp_code_description'.tr();
  static String get confirm => 'forget_password.confirm'.tr();
  static String get resetPassword => 'forget_password.reset_password'.tr();
  static String get resetPasswordDescription =>
      'forget_password.reset_password_description'.tr();
  static String get newPassword => 'forget_password.new_password'.tr();
  static String get confirmPassword => 'forget_password.confirm_password'.tr();
  static String get reset => 'forget_password.reset'.tr();
  static String get didntRecieveVerificationCode =>
      'forget_password.didnt_recieve_verification_code'.tr();
  static String get resendCode => 'forget_password.resend_code'.tr();
  static String get makeSureIts8CharactersOrMore =>
      'forget_password.make_sure_its_8_characters_or_more'.tr();
  static String get createNewPassword =>
      'forget_password.create_new_password'.tr();
  static String get done => 'forget_password.done'.tr();
  static String get pleaseEnterValidOtp =>
      'forget_password.please_enter_valid_otp'.tr();
  static String get otpSentSuccessfully =>
      'forget_password.otpSentSuccessfully'.tr();
  static String get pleaseEnterValidPassword =>
      'forget_password.please_enter_valid_password'.tr();
  static String get passwordResetSuccessfully =>
      'forget_password.passwordResetSuccessfully'.tr();
  static String get email => 'forget_password.email'.tr();
  static String get confirmPasswordDoesNotMatch =>
      'forget_password.confirmPasswordDoesNotMatch'.tr();
  static String get thePasswordMustBeAtLeast8CharactersLong =>
      'forget_password.thePasswordMustBeAtLeast8CharactersLong'.tr();
  //bottom nav bar
  static String get exploreIcon => 'bottom_nav_bar.explore'.tr();
  static String get smartCoachIcon => 'bottom_nav_bar.smart_coach'.tr();
  static String get workoutsIcon => 'bottom_nav_bar.workouts'.tr();
  static String get profileIcon => 'bottom_nav_bar.profile'.tr();
  // Workouts
  static String get upcomingWorkouts => 'workouts.upcoming_workouts'.tr();
  static String get workoutsSeeAll => 'workouts.see_all'.tr();
  static String get noWorkoutsFound => 'workouts.no_workouts_found'.tr();
  static String get workoutsAll => 'workouts.all'.tr();

  // Meals
  static String get mealsRecommendationForYou =>
      'meals.recommendation_for_you'.tr();
  static String get mealsSeeAll => 'meals.see_all'.tr();
  static String get noMealsFound => 'meals.no_meals_found'.tr();
  static String get foodRecommendation => 'meals.food_recommendation'.tr();

  // Smart Coach
  static String get smartCoach => 'smart_coach.smart_coach'.tr();
  static String get smartCoachGreeting => 'smart_coach.greeting'.tr();
  static String get smartCoachGreetingDescription =>
      'smart_coach.greeting_description'.tr();
  static String get smartCoachWelcomeMessage =>
      'smart_coach.welcome_message'.tr();
  static String get smartCoachGetStarted => 'smart_coach.get_started'.tr();
  static String get smartCoachNoResponse => 'smart_coach.no_response'.tr();
  static String get askSmartCoach => 'smart_coach.ask_smart_coach'.tr();
  static String get previousConversations =>
      'smart_coach.previous_conversations'.tr();
  static String get noPreviousConversations =>
      'smart_coach.no_previous_conversations'.tr();
  static String get clearAll => 'smart_coach.clear_all'.tr();
}
