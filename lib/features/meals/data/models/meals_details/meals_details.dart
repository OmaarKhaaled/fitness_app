import 'dart:convert';
import 'package:fitness_app/features/meals/data/models/meals_details/meal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'meals_details.g.dart';

@JsonSerializable()
class MealsDetails {
  @JsonKey(name: 'meals')
  final List<Meal>? meals;

  const MealsDetails({this.meals});

  factory MealsDetails.fromMap(Map<String, dynamic> data) =>
      _$MealsDetailsFromJson(data);

  Map<String, dynamic> toMap() => _$MealsDetailsToJson(this);

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MealsDetails].
  factory MealsDetails.fromJson(String data) =>
      _$MealsDetailsFromJson(json.decode(data));

  /// `dart:convert`
  ///
  /// Converts [MealsDetails] to a JSON string.
  String toJson() => json.encode(toMap());
}
