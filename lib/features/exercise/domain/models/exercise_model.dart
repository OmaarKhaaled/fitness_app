class ExerciseModel {
  final String id;
  final String name;
  final String? difficultyLevel;
  final String? targetMuscleGroup;
  final String? primeMoverMuscle;
  final String? primaryEquipment;
  final String? mechanics;
  final String? posture;
  final String? movementPattern1;
  final String? bodyRegion;
  final String? forceType;
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
    this.movementPattern1,
    this.bodyRegion,
    this.forceType,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });
}
