import 'package:freezed_annotation/freezed_annotation.dart';
import 'muscle.dart';
import 'muscle_group.dart';
part 'wourkout_group_response.g.dart';

@JsonSerializable()
class WourkoutGroupResponse {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'muscleGroup')
  final MuscleGroup? muscleGroup;
  @JsonKey(name: 'muscles')
  final List<Muscle>? muscles;

  const WourkoutGroupResponse({this.message, this.muscleGroup, this.muscles});

  factory WourkoutGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$WourkoutGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WourkoutGroupResponseToJson(this);
}
