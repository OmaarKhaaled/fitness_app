import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';

class ChatPageStates extends Equatable {
  final BaseState<String?>? profilePicUrl;
  final BaseState<List<Map<String, String>>>? messages;
  final BaseState<List<SessionModel>>? previousConversations;
  const ChatPageStates({
    this.profilePicUrl,
    this.messages,
    this.previousConversations,
  });

  ChatPageStates copyWith({
    BaseState<String?>? profilePicUrl,
    BaseState<List<Map<String, String>>>? messages,
    BaseState<List<SessionModel>>? previousConversations,
  }) {
    return ChatPageStates(
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      messages: messages ?? this.messages,
      previousConversations:
          previousConversations ?? this.previousConversations,
    );
  }

  @override
  List<Object?> get props => [profilePicUrl, messages, previousConversations];
}
