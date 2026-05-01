import 'package:fitness_app/features/meals/data/models/meals_by_category_response/meal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'meals_by_category_response.g.dart';

@JsonSerializable()
class MealsByCategoryResponse {
  final List<Meal>? meals;

  const MealsByCategoryResponse({this.meals});

  factory MealsByCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$MealsByCategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MealsByCategoryResponseToJson(this);
}
