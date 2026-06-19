import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/profile/domain/entities/profile_entity.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_cubit.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_intents.dart';
import 'package:fitness_app/features/auth/profile/presentation/view_model/profile_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../profile_test_mocks.mocks.dart';

void main() {
  late ProfileCubit cubit;
  late MockGetUserProfileUseCase mockGetUserProfileUseCase;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockGetUserProfileUseCase = MockGetUserProfileUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    cubit = ProfileCubit(mockGetUserProfileUseCase, mockLogoutUseCase);
  });

  group('ProfileCubit', () {
    const profileEntity = ProfileEntity(firstName: 'John', lastName: 'Doe');

    blocTest<ProfileCubit, ProfileStates>(
      'emits [isLoading: true, data: entity] when GetUserProfileIntent succeeds',
      build: () {
        when(
          mockGetUserProfileUseCase(),
        ).thenAnswer((_) async => const BaseResponse.success(profileEntity));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetUserProfileIntent()),
      expect: () => [
        ProfileStates(isLoading: true),
        ProfileStates(isLoading: false, data: profileEntity),
      ],
    );

    blocTest<ProfileCubit, ProfileStates>(
      'emits [isLoading: true, isLoading: false] when LogoutIntent succeeds',
      build: () {
        when(
          mockLogoutUseCase(),
        ).thenAnswer((_) async => const BaseResponse.success(null));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(LogoutIntent()),
      expect: () => [
        ProfileStates(isLoading: true),
        ProfileStates(isLoading: false),
      ],
    );
  });
}
