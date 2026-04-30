class ProfileUiIntents {}

class ShowErrorIntent extends ProfileUiIntents {
  final String errorMessage;
  ShowErrorIntent(this.errorMessage);
}
