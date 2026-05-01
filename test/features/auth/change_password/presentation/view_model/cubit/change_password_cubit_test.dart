import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/features/auth/change_password/domain/usecases/change_password_usecase.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:fitness_app/features/auth/change_password/presentation/view_model/cubit/change_paasword_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'change_password_cubit_test.mocks.dart';

@GenerateMocks([ChangePasswordUsecase])
void main() {
  late MockChangePasswordUsecase usecase;

  setUp(() {
    usecase = MockChangePasswordUsecase();
  });

  group('doIntent', () {
    blocTest<ChangePasswordCubit, ChangePasswordState>(
      'FormChangedIntent updates isFormValid to true',
      build: () => ChangePasswordCubit(usecase),
      act: (cubit) {
        cubit.currentPasswordController.text = 'OldPass1!';
        cubit.newPasswordController.text = '12345678Aa!';
        cubit.confirmPasswordController.text = '12345678Aa!';

        cubit.doIntent(FormChangedIntent());
      },
      // Setting controller text fires _onTextChanged listeners,
      // which emit states before FormChangedIntent runs.
      // We only care about the final state.
      expect: () => [
        isA<ChangePasswordState>().having(
          (s) => s.isFormValid,
          'isFormValid',
          false,
        ),
        isA<ChangePasswordState>().having(
          (s) => s.isFormValid,
          'isFormValid',
          true,
        ),
      ],
    );

    blocTest<ChangePasswordCubit, ChangePasswordState>(
      'ToggleCurrentPasswordVisibility toggles value',
      build: () => ChangePasswordCubit(usecase),
      act: (cubit) => cubit.doIntent(ToggleCurrentPasswordVisibility()),
      expect: () => [
        isA<ChangePasswordState>().having(
          (s) => s.currentPasswordVisible,
          'currentPasswordVisible',
          true,
        ),
      ],
    );

    blocTest<ChangePasswordCubit, ChangePasswordState>(
      'ToggleNewPasswordVisibility toggles value',
      build: () => ChangePasswordCubit(usecase),
      act: (cubit) => cubit.doIntent(ToggleNewPasswordVisibility()),
      expect: () => [
        isA<ChangePasswordState>().having(
          (s) => s.newPasswordVisible,
          'newPasswordVisible',
          true,
        ),
      ],
    );

    blocTest<ChangePasswordCubit, ChangePasswordState>(
      'ToggleConfirmPasswordVisibility toggles value',
      build: () => ChangePasswordCubit(usecase),
      act: (cubit) => cubit.doIntent(ToggleConfirmPasswordVisibility()),
      expect: () => [
        isA<ChangePasswordState>().having(
          (s) => s.confirmPasswordVisible,
          'confirmPasswordVisible',
          true,
        ),
      ],
    );
  });
}
