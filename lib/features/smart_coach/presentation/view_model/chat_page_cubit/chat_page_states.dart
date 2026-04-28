import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/base_state/base_state.dart';

class ChatPageStates extends Equatable {
  final BaseState<String?>? profilePicUrl;
  const ChatPageStates({this.profilePicUrl});

  ChatPageStates copyWith({BaseState<String?>? profilePicUrl}) {
    return ChatPageStates(profilePicUrl: profilePicUrl ?? this.profilePicUrl);
  }

  @override
  List<Object?> get props => [profilePicUrl];
}
