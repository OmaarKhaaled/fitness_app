class ExerciseModel {
  final String id;
  final String name;
  final String? difficultyLevel;
  final String? targetMuscleGroup;
  final String? primeMoverMuscle;
  final String? primaryEquipment;
  final String? mechanics;
  final String? posture;
  final String? bodyRegion;
  final String? forceType;
  final String? secondaryMuscle;
  final String? tertiaryMuscle;
  final String? primaryItems;
  final String? secondaryEquipment;
  final String? secondaryItems;
  final String? singleOrDoubleArm;
  final String? continuousOrAlternatingArms;
  final String? grip;
  final String? loadPositionEnding;
  final String? continuousOrAlternatingLegs;
  final String? footElevation;
  final String? combinationExercises;
  final String? movementPattern1;
  final String? movementPattern2;
  final String? movementPattern3;
  final String? planeOfMotion1;
  final String? planeOfMotion2;
  final String? planeOfMotion3;
  final String? laterality;
  final String? primaryExerciseClassification;
  final String? shortYoutubeDemonstrationLink;
  final String? inDepthYoutubeExplanationLink;

  const ExerciseModel({
    required this.id,
    required this.name,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.primaryEquipment,
    this.mechanics,
    this.posture,
    this.bodyRegion,
    this.forceType,
    this.secondaryMuscle,
    this.tertiaryMuscle,
    this.primaryItems,
    this.secondaryEquipment,
    this.secondaryItems,
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
    this.laterality,
    this.primaryExerciseClassification,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  
  String? get thumbnailUrl {
    if (shortYoutubeDemonstrationLink == null) return null;

    final id = _extractYoutubeId(shortYoutubeDemonstrationLink!);

    if (id == null) return null;

    return 'https://img.youtube.com/vi/$id/hqdefault.jpg';
  }

  String? _extractYoutubeId(String url) {
    final uri = Uri.parse(url);

    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    }

    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    }

    return null;
  }
}
