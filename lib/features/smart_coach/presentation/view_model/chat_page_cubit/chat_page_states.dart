import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/base_state/base_state.dart';

class ChatPageStates extends Equatable {
  final BaseState<String?>? profilePicUrl;
  final BaseState<List<Map<String, String>>>? messages;
  const ChatPageStates({this.profilePicUrl, this.messages});

  ChatPageStates copyWith({
    BaseState<String?>? profilePicUrl,
    BaseState<List<Map<String, String>>>? messages,
  }) {
    return ChatPageStates(
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [profilePicUrl, messages];
}
