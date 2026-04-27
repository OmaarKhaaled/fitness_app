import 'package:bloc/bloc.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/smart_coach/domain/usecases/get_first_name_use_case.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/cubit/samrt_coach_intents.dart';
import 'package:fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SmartCoachCubit extends Cubit<SmartCoachState> {
  final GetFirstNameUseCase _getFirstNameUseCase;
  SmartCoachCubit(this._getFirstNameUseCase) : super(const SmartCoachState());

  void doIntent(SmartCoachIntents intent) {
    switch (intent) {
      case GetFirstNameIntent():
        _getFirstName();
    }
  }

  Future<void> _getFirstName() async {
    final result = await _getFirstNameUseCase.call();
    result.when(
      initial: () => emit(
        state.copyWith(firstName: const BaseState<String?>(isLoading: true)),
      ),
      loading: () => emit(
        state.copyWith(firstName: const BaseState<String?>(isLoading: true)),
      ),
      success: (name) => emit(
        state.copyWith(
          firstName: BaseState<String?>(data: name, isLoading: false),
        ),
      ),
      failure: (f) => emit(
        state.copyWith(
          firstName: BaseState<String?>(
            errorMessage: f.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }
}
