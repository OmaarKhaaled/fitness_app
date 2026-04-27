import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'smart_coach_state.dart';

class SmartCoachCubit extends Cubit<SmartCoachState> {
  SmartCoachCubit() : super(SmartCoachInitial());
}
