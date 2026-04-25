import 'package:freezed_annotation/freezed_annotation.dart';
part 'muscle.g.dart';

@JsonSerializable()
class Muscle {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;

  const Muscle({this.id, this.name, this.image});

  factory Muscle.fromJson(Map<String, dynamic> json) => _$MuscleFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleToJson(this);
}
