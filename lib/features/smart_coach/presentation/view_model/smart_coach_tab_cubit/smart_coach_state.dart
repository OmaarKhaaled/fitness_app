import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/base_state/base_state.dart';

class SmartCoachState extends Equatable {
  final BaseState<String?>? firstName;
  const SmartCoachState({this.firstName});

  SmartCoachState copyWith({BaseState<String?>? firstName}) {
    return SmartCoachState(firstName: firstName ?? this.firstName);
  }

  @override
  List<Object?> get props => [firstName];
}
