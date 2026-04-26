import 'package:freezed_annotation/freezed_annotation.dart';
part 'meal.g.dart';

@JsonSerializable()
class Meal {
  @JsonKey(name: 'strMeal')
  final String? strMeal;
  @JsonKey(name: 'strMealThumb')
  final String? strMealThumb;
  @JsonKey(name: 'idMeal')
  final String? idMeal;

  const Meal({this.strMeal, this.strMealThumb, this.idMeal});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
  Map<String, dynamic> toJson() => _$MealToJson(this);
}
