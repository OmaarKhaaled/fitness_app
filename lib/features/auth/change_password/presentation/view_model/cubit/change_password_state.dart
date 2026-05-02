part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final BaseState<ChangePasswordModel> baseState;
  final bool isFormValid;
  final bool oldPasswordVisible;
  final bool newPasswordVisible;
  final bool confirmPasswordVisible;

  const ChangePasswordState({
    required this.baseState,
    this.isFormValid = false,
    this.oldPasswordVisible = false,
    this.newPasswordVisible = false,
    this.confirmPasswordVisible = false,
  });

  factory ChangePasswordState.initial() => const ChangePasswordState(
        baseState: BaseState(),
      );

  ChangePasswordState copyWith({
    BaseState<ChangePasswordModel>? baseState,
    bool? isFormValid,
    bool? oldPasswordVisible,
    bool? newPasswordVisible,
    bool? confirmPasswordVisible,
  }) {
    return ChangePasswordState(
      baseState: baseState ?? this.baseState,
      isFormValid: isFormValid ?? this.isFormValid,
      oldPasswordVisible: oldPasswordVisible ?? this.oldPasswordVisible,
      newPasswordVisible: newPasswordVisible ?? this.newPasswordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [
        baseState,
        isFormValid,
        oldPasswordVisible,
        newPasswordVisible,
        confirmPasswordVisible,
      ];
}