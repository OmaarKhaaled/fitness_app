import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/login/data/models/response/user_model.dart';
import 'package:fitness_app/features/auth/login/domain/models/login_model.dart';
import 'package:fitness_app/features/auth/login/domain/repos/login_repo.dart';
import 'package:fitness_app/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_usecase_test.mocks.dart';

@GenerateMocks([LoginRepo])
void main() {
  late MockLoginRepo mockLoginRepo;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockLoginRepo = MockLoginRepo();
    loginUseCase = LoginUseCase(mockLoginRepo);
    provideDummy<BaseResponse<LoginModel>>(
      BaseResponse.success(
        LoginModel(
          message: 'Login successful',
          token: 'token123',
          user: User(
            id: '1',
            firstName: 'John',
            lastName: 'Doe',
            email: 'john.doe@example.com',
          ),
        ),
      ),
    );
  });

  group('LoginUseCase => call()', () {
    test(
      'should return BaseResponse<LoginModel> when login is successful',
      () async {
        // Arrange
        const email = 'john.doe@example.com';
        const password = 'password123';
        LoginRequest loginRequest = LoginRequest(
          email: email,
          password: password,
        );

        when(mockLoginRepo.login(loginRequest)).thenAnswer(
          (_) async => BaseResponse.success(
            LoginModel(
              message: 'Login successful',
              token: 'token123',
              user: User(
                id: '1',
                firstName: 'John',
                lastName: 'Doe',
                email: email,
              ),
            ),
          ),
        );

        // Act
        final result = await loginUseCase(loginRequest);

        // Assert
        expect(result, isA<BaseResponse<LoginModel>>());
      },
    );
  });
}
