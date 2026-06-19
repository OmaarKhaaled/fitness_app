import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_random_prime_mover_muscle_use_case.dart';
import 'package:fitness_app/features/recommendations/presentation/view_model/recommendation_states.dart';
import 'package:fitness_app/features/recommendations/presentation/view_model/recommendation_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecommendationCubit extends Cubit<RecommendationStates> {
  final GetRandom20PrimeMoverMuscleUseCase _getRecommendationsUseCase;

  RecommendationCubit({
    required GetRandom20PrimeMoverMuscleUseCase getRecommendationsUseCase,
  }) : _getRecommendationsUseCase = getRecommendationsUseCase,
       super(RecommendationStates());

  void doIntent(RecommendationIntents intent) {
    switch (intent) {
      case LoadRecommendationsIntent():
        _loadRecommendations();
        break;
    }
  }

  Future<void> _loadRecommendations() async {
    emit(state.copyWith(isLoading: true));
    final response = await _getRecommendationsUseCase();
    response.when(
      initial: () => null,
      loading: () => null,
      success: (data) {
        emit(state.copyWith(isLoading: false, data: data.muscles ?? []));
      },
      failure: (error) {
        emit(state.copyWith(isLoading: false, errorMessage: error.message));
      },
    );
  }
}
