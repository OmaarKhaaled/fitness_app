import 'package:bloc/bloc.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/meals/data/models/meals_details/meals_details.dart';
import 'package:fitness_app/features/meals/domain/use_cases/get_meal_details_use_case.dart';
import 'package:injectable/injectable.dart';

part 'meal_detail_state.dart';

@injectable
class MealDetailCubit extends Cubit<MealDetailState> {
  final GetMealDetailsUseCase _getMealDetailsUseCase;
  MealDetailCubit(this._getMealDetailsUseCase) : super(MealDetailState());

  Future<void> getMealDetails(String mealId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await _getMealDetailsUseCase(mealId);

    response.when(
      initial: () => null,
      loading: () => null,
      success: (data) {
        emit(state.copyWith(mealDetails: data, isLoading: false));
      },
      failure: (error) {
        emit(state.copyWith(errorMessage: error.message, isLoading: false));
      },
    );
  }
}
