sealed class ChatPageIntents {}

class GetProfilePicUrlIntent extends ChatPageIntents {}

class SendMessageIntent extends ChatPageIntents {
  final String userMessage;
  SendMessageIntent(this.userMessage);
}
