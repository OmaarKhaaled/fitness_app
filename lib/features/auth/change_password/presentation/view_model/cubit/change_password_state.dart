
part of 'change_password_cubit.dart';
class ChangePasswordState extends Equatable {
  final BaseState<ChangePasswordModel> baseState;
  final bool isFormValid;
  final bool currentPasswordVisible;
  final bool newPasswordVisible;
  final bool confirmPasswordVisible;

  const ChangePasswordState({
    required this.baseState,
    this.isFormValid = false,
    this.currentPasswordVisible = false,
    this.newPasswordVisible = false,
    this.confirmPasswordVisible = false,
  });

  factory ChangePasswordState.initial() => const ChangePasswordState(
        baseState: BaseState<ChangePasswordModel>(),
      );

  ChangePasswordState copyWith({
    BaseState<ChangePasswordModel>? baseState,
    bool? isFormValid,
    bool? currentPasswordVisible,
    bool? newPasswordVisible,
    bool? confirmPasswordVisible,
  }) {
    return ChangePasswordState(
      baseState: baseState ?? this.baseState,
      isFormValid: isFormValid ?? this.isFormValid,
      currentPasswordVisible: currentPasswordVisible ?? this.currentPasswordVisible,
      newPasswordVisible: newPasswordVisible ?? this.newPasswordVisible,
      confirmPasswordVisible: confirmPasswordVisible ?? this.confirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [
        baseState,
        isFormValid,
        currentPasswordVisible,
        newPasswordVisible,
        confirmPasswordVisible,
      ];
}
