import 'package:freezed_annotation/freezed_annotation.dart';
part 'muscle_group.g.dart';

@JsonSerializable()
class MuscleGroup {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;

  const MuscleGroup({this.id, this.name});

  factory MuscleGroup.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupToJson(this);
}
