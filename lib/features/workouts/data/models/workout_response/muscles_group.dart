import 'package:freezed_annotation/freezed_annotation.dart';
part 'muscles_group.g.dart';

@JsonSerializable()
class MusclesGroup {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;

  const MusclesGroup({this.id, this.name});

  factory MusclesGroup.fromJson(Map<String, dynamic> json) =>
      _$MusclesGroupFromJson(json);

  Map<String, dynamic> toJson() => _$MusclesGroupToJson(this);
}
