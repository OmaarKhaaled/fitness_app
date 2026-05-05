import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/popular_tarining/domain/models/popular_training_item.dart';

class PopularTrainingStates extends BaseState<List<PopularTrainingItem>> {
  const PopularTrainingStates({
    super.isLoading = false,
    super.data = const [],
    super.errorMessage,
  });

  PopularTrainingStates copyWith({
    bool? isLoading,
    List<PopularTrainingItem>? data,
    String? errorMessage,
  }) {
    return PopularTrainingStates(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}
