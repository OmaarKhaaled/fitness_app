import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/workouts/data/models/prime_mover_muscle_response/muscle.dart';

class RecommendationStates extends BaseState<List<Muscle>> {
  RecommendationStates({
    super.data,
    super.errorMessage,
    super.isLoading = false,
  });

  RecommendationStates copyWith({
    bool? isLoading,
    List<Muscle>? data,
    String? errorMessage,
  }) {
    return RecommendationStates(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}
