import 'package:freezed_annotation/freezed_annotation.dart';
import 'muscles_group.dart';
part 'workout_response.g.dart';

@JsonSerializable()
class WorkoutResponse {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'musclesGroup')
  final List<MusclesGroup>? musclesGroup;

  const WorkoutResponse({this.message, this.musclesGroup});

  factory WorkoutResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutResponseToJson(this);
}
