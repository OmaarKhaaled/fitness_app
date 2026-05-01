import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/features/auth/login/data/data_source/login_local_data_source.dart';
import 'package:fitness_app/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:fitness_app/features/auth/login/data/models/request/login_request.dart';
import 'package:fitness_app/features/auth/login/data/models/response/login_response.dart';
import 'package:fitness_app/features/auth/login/data/models/response/user_model.dart';
import 'package:fitness_app/features/auth/login/data/repos/login_repo_impl.dart';
import 'package:fitness_app/features/auth/login/domain/models/login_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'login_repo_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSource, LoginLocalDataSource])
void main() {
  late MockLoginRemoteDataSource mockLoginRemoteDataSource;
  late MockLoginLocalDataSource mockLoginLocalDataSource;
  late LoginRepoImpl loginRepoImpl;

  const email = 'john@example.com';
  const password = 'password123';

  late LoginResponse loginResponse;

  setUp(() {
    mockLoginRemoteDataSource = MockLoginRemoteDataSource();
    mockLoginLocalDataSource = MockLoginLocalDataSource();
    loginRepoImpl = LoginRepoImpl(
      mockLoginRemoteDataSource,
      mockLoginLocalDataSource,
    );

    loginResponse = LoginResponse(
      message: 'Login successful',
      user: User(id: '1', firstName: 'John', lastName: 'Doe', email: email),
      token: 'token123',
    );
  });

  group('LoginRepoImpl => login()', () {
    test(
      'should return BaseResponse.success<LoginModel> when remote call succeeds',
      () async {
        // Arrange
        final request = LoginRequest(email: email, password: password);

        when(
          mockLoginRemoteDataSource.login(request),
        ).thenAnswer((_) async => BaseResponse.success(loginResponse));

        when(
          mockLoginLocalDataSource.saveUserData(
            firstName: anyNamed('firstName'),
            imageUrl: anyNamed('imageUrl'),
          ),
        ).thenAnswer((_) async => const BaseResponse.success(null));

        // Act
        final result = await loginRepoImpl.login(request);

        // Assert
        verify(mockLoginRemoteDataSource.login(request)).called(1);

        expect(result, isA<BaseResponse<LoginModel>>());

        result.when(
          initial: () => fail('Expected success'),
          loading: () => fail('Expected success'),
          failure: (_) => fail('Expected success'),
          success: (data) {
            expect(data.message, 'Login successful');
            expect(data.token, 'token123');
            expect(data.user.email, email);
          },
        );
      },
    );

    test('should return BaseResponse.failure when remote call fails', () async {
      // Arrange
      final request = LoginRequest(email: email, password: password);

      const exception = AppException('Login failed');

      when(
        mockLoginRemoteDataSource.login(request),
      ).thenAnswer((_) async => const BaseResponse.failure(exception));

      // Act
      final result = await loginRepoImpl.login(request);

      // Assert
      verify(mockLoginRemoteDataSource.login(request)).called(1);

      expect(result, isA<BaseResponse<LoginModel>>());

      result.when(
        initial: () => fail('Expected failure'),
        loading: () => fail('Expected failure'),
        success: (_) => fail('Expected failure'),
        failure: (error) {
          expect(error, exception);
        },
      );
    });

    test(
      'should return BaseResponse.loading when datasource returns loading',
      () async {
        final request = LoginRequest(email: email, password: password);

        when(
          mockLoginRemoteDataSource.login(request),
        ).thenAnswer((_) async => const BaseResponse.loading());

        final result = await loginRepoImpl.login(request);

        result.when(
          initial: () => fail('Expected loading'),
          loading: () => expect(true, true),
          success: (_) => fail('Expected loading'),
          failure: (_) => fail('Expected loading'),
        );
      },
    );

    test(
      'should return BaseResponse.initial when datasource returns initial',
      () async {
        final request = LoginRequest(email: email, password: password);

        when(
          mockLoginRemoteDataSource.login(request),
        ).thenAnswer((_) async => const BaseResponse.initial());

        final result = await loginRepoImpl.login(request);

        result.when(
          initial: () => expect(true, true),
          loading: () => fail('Expected initial'),
          success: (_) => fail('Expected initial'),
          failure: (_) => fail('Expected initial'),
        );
      },
    );
  });
}
