import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/profile/data/repositories/profile_repository_impl.dart';
import 'package:fitness_app/features/auth/profile/data/response/profile_response.dart';
import 'package:fitness_app/features/auth/profile/data/response/user.dart';
import 'package:fitness_app/features/auth/profile/domain/entities/profile_entity.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../profile_test_mocks.mocks.dart';

void main() {
  late ProfileRepositoryImpl repository;
  late MockProfileDataSource mockDataSource;
  late MockSecureStorageService mockSecureStorage;

  setUp(() {
    mockDataSource = MockProfileDataSource();
    mockSecureStorage = MockSecureStorageService();
    repository = ProfileRepositoryImpl(mockDataSource, mockSecureStorage);
  });

  group('ProfileRepositoryImpl', () {
    test(
      'getLoggedUserProfile should return mapped ProfileEntity when data source succeeds',
      () async {
        // Arrange
        final userResponse = ProfileResponse(
          user: User(firstName: 'John', lastName: 'Doe'),
        );
        when(
          mockDataSource.getLoggedUserProfile(),
        ).thenAnswer((_) async => BaseResponse.success(userResponse));

        // Act
        final result = await repository.getLoggedUserProfile();

        // Assert
        expect(result, isA<BaseSuccess<ProfileEntity>>());
        final entity = (result as BaseSuccess<ProfileEntity>).data;
        expect(entity.firstName, 'John');
        expect(entity.lastName, 'Doe');
        verify(mockDataSource.getLoggedUserProfile()).called(1);
      },
    );

    test(
      'logout should clear tokens and return success when data source succeeds',
      () async {
        // Arrange
        when(
          mockDataSource.logout(),
        ).thenAnswer((_) async => const BaseResponse.success(null));
        when(
          mockSecureStorage.delete(StorageKeys.accessToken),
        ).thenAnswer((_) async => const BaseResponse.success(true));
        when(
          mockSecureStorage.writeBool(StorageKeys.isLoggedIn, false),
        ).thenAnswer((_) async => const BaseResponse.success(true));

        // Act
        final result = await repository.logout();

        // Assert
        expect(result, isA<BaseSuccess<void>>());
        verify(mockDataSource.logout()).called(1);
        verify(mockSecureStorage.delete(StorageKeys.accessToken)).called(1);
        verify(
          mockSecureStorage.writeBool(StorageKeys.isLoggedIn, false),
        ).called(1);
      },
    );
  });
}
