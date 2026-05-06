class MealsUiIntents {
  MealsUiIntents();
}

class ShowErrorMealsIntent extends MealsUiIntents {
  final String error;
  ShowErrorMealsIntent({required this.error});
}

class NavigateToMealsPageIntent extends MealsUiIntents {}
