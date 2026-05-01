import 'package:json_annotation/json_annotation.dart';

part 'exercise_response.g.dart';

@JsonSerializable()
class ExerciseResponse {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'totalExercises')
  final int? totalExercises;
  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'currentPage')
  final int? currentPage;
  @JsonKey(name: 'exercises')
  final List<Exercise>? exercises;

  ExerciseResponse({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  ExerciseResponse copyWith({
    String? message,
    int? totalExercises,
    int? totalPages,
    int? currentPage,
    List<Exercise>? exercises,
  }) => ExerciseResponse(
    message: message ?? this.message,
    totalExercises: totalExercises ?? this.totalExercises,
    totalPages: totalPages ?? this.totalPages,
    currentPage: currentPage ?? this.currentPage,
    exercises: exercises ?? this.exercises,
  );

  factory ExerciseResponse.fromJson(Map<String, dynamic> json) =>
      _$ExerciseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseResponseToJson(this);
}

@JsonSerializable()
class Exercise {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'exercise')
  final String? exercise;
  @JsonKey(name: 'short_youtube_demonstration')
  final String? shortYoutubeDemonstration;
  @JsonKey(name: 'in_depth_youtube_explanation')
  final String? inDepthYoutubeExplanation;
  @JsonKey(name: 'difficulty_level')
  final String? difficultyLevel;
  @JsonKey(name: 'target_muscle_group')
  final String? targetMuscleGroup;
  @JsonKey(name: 'prime_mover_muscle')
  final String? primeMoverMuscle;
  @JsonKey(name: 'secondary_muscle')
  final dynamic secondaryMuscle;
  @JsonKey(name: 'tertiary_muscle')
  final dynamic tertiaryMuscle;
  @JsonKey(name: 'primary_equipment')
  final String? primaryEquipment;
  @JsonKey(name: '_primary_items')
  final int? primaryItems;
  @JsonKey(name: 'secondary_equipment')
  final dynamic secondaryEquipment;
  @JsonKey(name: '_secondary_items')
  final int? secondaryItems;
  @JsonKey(name: 'posture')
  final String? posture;
  @JsonKey(name: 'single_or_double_arm')
  final String? singleOrDoubleArm;
  @JsonKey(name: 'continuous_or_alternating_arms')
  final String? continuousOrAlternatingArms;
  @JsonKey(name: 'grip')
  final String? grip;
  @JsonKey(name: 'load_position_ending')
  final String? loadPositionEnding;
  @JsonKey(name: 'continuous_or_alternating_legs')
  final String? continuousOrAlternatingLegs;
  @JsonKey(name: 'foot_elevation')
  final String? footElevation;
  @JsonKey(name: 'combination_exercises')
  final String? combinationExercises;
  @JsonKey(name: 'movement_pattern_1')
  final String? movementPattern1;
  @JsonKey(name: 'movement_pattern_2')
  final String? movementPattern2;
  @JsonKey(name: 'movement_pattern_3')
  final dynamic movementPattern3;
  @JsonKey(name: 'plane_of_motion_1')
  final String? planeOfMotion1;
  @JsonKey(name: 'plane_of_motion_2')
  final String? planeOfMotion2;
  @JsonKey(name: 'plane_of_motion_3')
  final dynamic planeOfMotion3;
  @JsonKey(name: 'body_region')
  final String? bodyRegion;
  @JsonKey(name: 'force_type')
  final String? forceType;
  @JsonKey(name: 'mechanics')
  final String? mechanics;
  @JsonKey(name: 'laterality')
  final String? laterality;
  @JsonKey(name: 'primary_exercise_classification')
  final String? primaryExerciseClassification;
  @JsonKey(name: 'short_youtube_demonstration_link')
  final String? shortYoutubeDemonstrationLink;
  @JsonKey(name: 'in_depth_youtube_explanation_link')
  final String? inDepthYoutubeExplanationLink;

  Exercise({
    this.id,
    this.exercise,
    this.shortYoutubeDemonstration,
    this.inDepthYoutubeExplanation,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.secondaryMuscle,
    this.tertiaryMuscle,
    this.primaryEquipment,
    this.primaryItems,
    this.secondaryEquipment,
    this.secondaryItems,
    this.posture,
    this.singleOrDoubleArm,
    this.continuousOrAlternatingArms,
    this.grip,
    this.loadPositionEnding,
    this.continuousOrAlternatingLegs,
    this.footElevation,
    this.combinationExercises,
    this.movementPattern1,
    this.movementPattern2,
    this.movementPattern3,
    this.planeOfMotion1,
    this.planeOfMotion2,
    this.planeOfMotion3,
    this.bodyRegion,
    this.forceType,
    this.mechanics,
    this.laterality,
    this.primaryExerciseClassification,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  Exercise copyWith({
    String? id,
    String? exercise,
    String? shortYoutubeDemonstration,
    String? inDepthYoutubeExplanation,
    String? difficultyLevel,
    String? targetMuscleGroup,
    String? primeMoverMuscle,
    dynamic secondaryMuscle,
    dynamic tertiaryMuscle,
    String? primaryEquipment,
    int? primaryItems,
    dynamic secondaryEquipment,
    int? secondaryItems,
    String? posture,
    String? singleOrDoubleArm,
    String? continuousOrAlternatingArms,
    String? grip,
    String? loadPositionEnding,
    String? continuousOrAlternatingLegs,
    String? footElevation,
    String? combinationExercises,
    String? movementPattern1,
    String? movementPattern2,
    dynamic movementPattern3,
    String? planeOfMotion1,
    String? planeOfMotion2,
    dynamic planeOfMotion3,
    String? bodyRegion,
    String? forceType,
    String? mechanics,
    String? laterality,
    String? primaryExerciseClassification,
    String? shortYoutubeDemonstrationLink,
    String? inDepthYoutubeExplanationLink,
  }) => Exercise(
    id: id ?? this.id,
    exercise: exercise ?? this.exercise,
    shortYoutubeDemonstration:
        shortYoutubeDemonstration ?? this.shortYoutubeDemonstration,
    inDepthYoutubeExplanation:
        inDepthYoutubeExplanation ?? this.inDepthYoutubeExplanation,
    difficultyLevel: difficultyLevel ?? this.difficultyLevel,
    targetMuscleGroup: targetMuscleGroup ?? this.targetMuscleGroup,
    primeMoverMuscle: primeMoverMuscle ?? this.primeMoverMuscle,
    secondaryMuscle: secondaryMuscle ?? this.secondaryMuscle,
    tertiaryMuscle: tertiaryMuscle ?? this.tertiaryMuscle,
    primaryEquipment: primaryEquipment ?? this.primaryEquipment,
    primaryItems: primaryItems ?? this.primaryItems,
    secondaryEquipment: secondaryEquipment ?? this.secondaryEquipment,
    secondaryItems: secondaryItems ?? this.secondaryItems,
    posture: posture ?? this.posture,
    singleOrDoubleArm: singleOrDoubleArm ?? this.singleOrDoubleArm,
    continuousOrAlternatingArms:
        continuousOrAlternatingArms ?? this.continuousOrAlternatingArms,
    grip: grip ?? this.grip,
    loadPositionEnding: loadPositionEnding ?? this.loadPositionEnding,
    continuousOrAlternatingLegs:
        continuousOrAlternatingLegs ?? this.continuousOrAlternatingLegs,
    footElevation: footElevation ?? this.footElevation,
    combinationExercises: combinationExercises ?? this.combinationExercises,
    movementPattern1: movementPattern1 ?? this.movementPattern1,
    movementPattern2: movementPattern2 ?? this.movementPattern2,
    movementPattern3: movementPattern3 ?? this.movementPattern3,
    planeOfMotion1: planeOfMotion1 ?? this.planeOfMotion1,
    planeOfMotion2: planeOfMotion2 ?? this.planeOfMotion2,
    planeOfMotion3: planeOfMotion3 ?? this.planeOfMotion3,
    bodyRegion: bodyRegion ?? this.bodyRegion,
    forceType: forceType ?? this.forceType,
    mechanics: mechanics ?? this.mechanics,
    laterality: laterality ?? this.laterality,
    primaryExerciseClassification:
        primaryExerciseClassification ?? this.primaryExerciseClassification,
    shortYoutubeDemonstrationLink:
        shortYoutubeDemonstrationLink ?? this.shortYoutubeDemonstrationLink,
    inDepthYoutubeExplanationLink:
        inDepthYoutubeExplanationLink ?? this.inDepthYoutubeExplanationLink,
  );

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  /// Prefer short demo link first
  String? get videoUrl =>
      shortYoutubeDemonstrationLink ?? inDepthYoutubeExplanationLink;

  /// Thumbnail getter
  String? get thumbnailUrl {
    final url = videoUrl;
    if (url == null || url.isEmpty) return null;

    final id = _extractYoutubeId(url);
    if (id == null) return null;

    return 'https://img.youtube.com/vi/$id/hqdefault.jpg';
  }

  String? _extractYoutubeId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    }

    return null;
  }
}
