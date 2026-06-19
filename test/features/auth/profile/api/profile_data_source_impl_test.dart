import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/profile/api/profile_data_source_impl.dart';
import 'package:fitness_app/features/auth/profile/data/response/profile_response.dart';
import 'package:fitness_app/features/auth/profile/data/response/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../profile_test_mocks.mocks.dart';

void main() {
  late ProfileDataSourceImpl dataSource;
  late MockProfileApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockProfileApiClient();
    dataSource = ProfileDataSourceImpl(mockApiClient);
  });

  group('ProfileDataSourceImpl', () {
    test(
      'getLoggedUserProfile should return success response when API call is successful',
      () async {
        // Arrange
        final userResponse = ProfileResponse(
          user: User(firstName: 'John', lastName: 'Doe'),
        );
        when(
          mockApiClient.getLoggedUserData(),
        ).thenAnswer((_) async => userResponse);

        // Act
        final result = await dataSource.getLoggedUserProfile();

        // Assert
        expect(
          result.when(
            success: (data) => data,
            failure: (_) => null,
            initial: () => null,
            loading: () => null,
          ),
          equals(userResponse),
        );
        verify(mockApiClient.getLoggedUserData()).called(1);
      },
    );

    test(
      'logout should return success response when API call is successful',
      () async {
        // Arrange
        when(mockApiClient.logout()).thenAnswer((_) async => null);

        // Act
        final result = await dataSource.logout();

        // Assert
        expect(result, isA<BaseSuccess<void>>());
        verify(mockApiClient.logout()).called(1);
      },
    );
  });
}
