import 'package:freezed_annotation/freezed_annotation.dart';
import 'muscle.dart';
part 'prime_mover_muscle_response.g.dart';

@JsonSerializable()
class PrimeMoverMuscleResponse {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'totalMuscles')
  final int? totalMuscles;
  @JsonKey(name: 'muscles')
  final List<Muscle>? muscles;

  const PrimeMoverMuscleResponse({
    this.message,
    this.totalMuscles,
    this.muscles,
  });

  factory PrimeMoverMuscleResponse.fromJson(Map<String, dynamic> json) =>
      _$PrimeMoverMuscleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrimeMoverMuscleResponseToJson(this);
}
