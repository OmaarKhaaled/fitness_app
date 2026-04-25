import 'package:fitness_app/features/exercise/api/exercise_.remote_data_source_impl.dart';
import 'package:fitness_app/features/exercise/data/models/response/levels_by_primemuscle_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../auth/api/aurh_remote_data_source_impl_test.mocks.dart';

void main() {
  late MockApiClient mockApiClient;
  late ExerciseRemoteDataSourceImpl exerciseRemoteDataSourceImpl;

  setUpAll(() {
    mockApiClient = MockApiClient();
    exerciseRemoteDataSourceImpl = ExerciseRemoteDataSourceImpl(mockApiClient);
  });

  test('Get levels by prime mover muscle', () async {
    const token = 'test_token';
    const primeMoverMuscleId = 'test_prime_mover_muscle_id';

    when(mockApiClient.getDifficultyLevelsByPrimeMoverMuscle(token, primeMoverMuscleId))
        .thenAnswer((_) async => LevelsByPrimemuscleResponse(
      message: 'Levels fetched successfully',
      difficultyLevels: [],
    ));

    final response = await exerciseRemoteDataSourceImpl.getAllDifficultyLevelsByPrimeMoverMuscle(
      token,
      primeMoverMuscleId,
    );

    expect(response.message, 'Levels fetched successfully');
    expect(response.difficultyLevels, isA<List<DifficultyLevel>>());
  });

  test('Get exercises by prime mover muscle and difficulty level', () async {

  });
}
