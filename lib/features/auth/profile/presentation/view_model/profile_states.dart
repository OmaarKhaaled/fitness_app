import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/auth/profile/domain/entities/profile_entity.dart';

class ProfileStates extends BaseState<ProfileEntity> {
  ProfileStates({super.data, super.errorMessage, super.isLoading});

  @override
  ProfileStates copyWith({
    ProfileEntity? data,
    String? errorMessage,
    bool? isLoading,
    bool? isEnglish,
  }) {
    return ProfileStates(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [data, errorMessage, isLoading];
}
