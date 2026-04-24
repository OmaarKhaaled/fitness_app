import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/services/token_service.dart';
import 'package:fitness_app/features/auth/login/data/models/response/user_model.dart';
import 'package:fitness_app/features/auth/login/domain/models/login_model.dart';
import 'package:fitness_app/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:fitness_app/features/auth/login/presentation/manager/manager/login_cubit.dart';
import 'package:fitness_app/features/auth/login/presentation/manager/manager/login_intent.dart';
import 'package:fitness_app/features/auth/login/presentation/manager/manager/login_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase, TokenService])
void main() {
  late MockTokenService tokenService;
  late MockLoginUseCase loginUseCase;
  late LoginCubit loginCubit;
  setUp(() {
    tokenService = MockTokenService();
    loginUseCase = MockLoginUseCase();
    loginCubit = LoginCubit(loginUseCase, tokenService);
  });
  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit', () {
    test('should initialize with correct initial state', () {
      expect(loginCubit.state, equals(LoginStates.initial()));
      expect(
        loginCubit.state,
        isNot(equals(LoginStates.initial().copyWith(rememberMe: true))),
      );
    });

    blocTest<LoginCubit, LoginStates>(
      'emits loading then success when login succeeds',
      build: () {
        final mockLoginModel = LoginModel(
          message: 'Login successful',
          token: 'token123',
          user: User(
            id: '1',
            firstName: 'John',
            lastName: 'Doe',
            email: 'test@example.com',
          ),
        );

        when(
          loginUseCase.call(any),
        ).thenAnswer((_) async => BaseResponse.success(mockLoginModel));

        when(
          tokenService.saveToken(any),
        ).thenAnswer((_) async => const BaseResponse.success(true));

        return loginCubit;
      },

      act: (cubit) => cubit.doIntent(
        PerformLogin(
          email: 'test@example.com',
          password: 'password123',
          rememberMe: false,
        ),
      ),

      expect: () => [
        LoginStates.initial().copyWith(
          loginResource: const BaseResponse.loading(),
        ),
        isA<LoginStates>(),
      ],
    );
  });
}
