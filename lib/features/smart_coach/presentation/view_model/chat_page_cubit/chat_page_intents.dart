sealed class ChatPageIntents {}

class GetProfilePicUrlIntent extends ChatPageIntents {}

class SendMessageIntent extends ChatPageIntents {
  final String userMessage;
  SendMessageIntent(this.userMessage);
}

class GetPreviousConversationsIntent extends ChatPageIntents {
  GetPreviousConversationsIntent();
}

class LoadSessionIntent extends ChatPageIntents {
  final String sessionId;
  LoadSessionIntent(this.sessionId);
}

class DeleteAllSessionsIntent extends ChatPageIntents {
  DeleteAllSessionsIntent();
}
