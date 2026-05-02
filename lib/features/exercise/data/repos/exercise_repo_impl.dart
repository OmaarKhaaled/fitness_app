import 'dart:core';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/api_call.dart';
import 'package:fitness_app/core/api_manager/api_client.dart';
import 'package:fitness_app/features/exercise/data/datasource/exercise_.remote_data_source.dart';
import 'package:fitness_app/features/exercise/domain/models/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/models/level_model.dart';
import 'package:fitness_app/features/exercise/domain/repo/exercise_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseRemoteDataSource exerciseRemoteDataSource;
  final ApiClient apiClient;
  ExerciseRepoImpl(this.exerciseRemoteDataSource, this.apiClient);

  @override
  Future<BaseResponse<List<LevelModel>>> getDifficultyLevelsByPrimeMoverMuscle(
    String token,
    String primeMoverMuscleId,
  ) {
    return apiCall(() async {
      final result = await apiClient.getDifficultyLevelsByPrimeMoverMuscle(
        token,
        primeMoverMuscleId,
      );
      return result.difficultyLevels
              ?.map((e) => LevelModel(id: e.id ?? '', name: e.name ?? ''))
              .toList() ??
          [];
    });
  }

  @override
  Future<BaseResponse<List<ExerciseModel>>>
  getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  ) {
    return apiCall(() async {
      final result = await apiClient
          .getExercisesbyPrimeMoverMuscleAndDifficultyLevel(
            primeMoverMuscleId,
            difficultyLevelId,
          );
      return result.exercises
              ?.map(
                (e) => ExerciseModel(
                  id: e.id ?? '',
                  name: e.exercise ?? '',
                  difficultyLevel: e.difficultyLevel,
                  targetMuscleGroup: e.targetMuscleGroup,
                  primeMoverMuscle: e.primeMoverMuscle,
                  primaryEquipment: e.primaryEquipment,
                  mechanics: e.mechanics,
                  posture: e.posture,
                  bodyRegion: e.bodyRegion,
                  forceType: e.forceType,
                  secondaryMuscle: e.secondaryMuscle?.toString(),
                  tertiaryMuscle: e.tertiaryMuscle?.toString(),
                  primaryItems: e.primaryItems?.toString(),
                  secondaryEquipment: e.secondaryEquipment?.toString(),
                  secondaryItems: e.secondaryItems?.toString(),
                  singleOrDoubleArm: e.singleOrDoubleArm,
                  continuousOrAlternatingArms: e.continuousOrAlternatingArms,
                  grip: e.grip,
                  loadPositionEnding: e.loadPositionEnding,
                  continuousOrAlternatingLegs: e.continuousOrAlternatingLegs,
                  footElevation: e.footElevation,
                  combinationExercises: e.combinationExercises,
                  movementPattern1: e.movementPattern1,
                  movementPattern2: e.movementPattern2,
                  movementPattern3: e.movementPattern3?.toString(),
                  planeOfMotion1: e.planeOfMotion1,
                  planeOfMotion2: e.planeOfMotion2,
                  planeOfMotion3: e.planeOfMotion3?.toString(),
                  laterality: e.laterality,
                  primaryExerciseClassification:
                      e.primaryExerciseClassification,
                  shortYoutubeDemonstrationLink:
                      e.shortYoutubeDemonstrationLink,
                  inDepthYoutubeExplanationLink:
                      e.inDepthYoutubeExplanationLink,
                ),
              )
              .toList() ??
          [];
    });
  }
}
