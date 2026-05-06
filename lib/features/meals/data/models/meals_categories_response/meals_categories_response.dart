import 'package:fitness_app/features/meals/data/models/meals_categories_response/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'meals_categories_response.g.dart';

@JsonSerializable()
class MealsCategoriesResponse {
  final List<Category>? categories;

  const MealsCategoriesResponse({this.categories});

  factory MealsCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$MealsCategoriesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MealsCategoriesResponseToJson(this);
}
