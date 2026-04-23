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
  static String get loginRegisterLink => 'login.register_link'.tr();

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
}
