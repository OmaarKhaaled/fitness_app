import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/smart_coach/data/models/session_model.dart';

class ChatPageStates extends Equatable {
  final BaseState<String?>? profilePicUrl;
  final bool isFirstMessage;
  final BaseState<SessionModel>? currentSession;
  final BaseState<List<SessionModel>>? previousConversations;
  const ChatPageStates({
    this.profilePicUrl,
    this.isFirstMessage = true,
    this.currentSession,
    this.previousConversations,
  });

  ChatPageStates copyWith({
    BaseState<String?>? profilePicUrl,
    bool? isFirstMessage,
    BaseState<SessionModel>? currentSession,
    BaseState<List<SessionModel>>? previousConversations,
  }) {
    return ChatPageStates(
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      isFirstMessage: isFirstMessage ?? this.isFirstMessage,
      currentSession: currentSession ?? this.currentSession,
      previousConversations:
          previousConversations ?? this.previousConversations,
    );
  }

  @override
  List<Object?> get props => [
    profilePicUrl,
    isFirstMessage,
    currentSession,
    previousConversations,
  ];
}
