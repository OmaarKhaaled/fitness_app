import 'package:json_annotation/json_annotation.dart';

part 'levels_by_primemuscle_response.g.dart';

@JsonSerializable()
class LevelsByPrimemuscleResponse {
    @JsonKey(name: 'message')
    final String? message;
    @JsonKey(name: 'totalLevels')
    final int? totalLevels;
    @JsonKey(name: 'difficulty_levels')
    final List<DifficultyLevel>? difficultyLevels;

    LevelsByPrimemuscleResponse({
        this.message,
        this.totalLevels,
        this.difficultyLevels,
    });

    LevelsByPrimemuscleResponse copyWith({
        String? message,
        int? totalLevels,
        List<DifficultyLevel>? difficultyLevels,
    }) => 
        LevelsByPrimemuscleResponse(
            message: message ?? this.message,
            totalLevels: totalLevels ?? this.totalLevels,
            difficultyLevels: difficultyLevels ?? this.difficultyLevels,
        );

    factory LevelsByPrimemuscleResponse.fromJson(Map<String, dynamic> json) => _$LevelsByPrimemuscleResponseFromJson(json);

    Map<String, dynamic> toJson() => _$LevelsByPrimemuscleResponseToJson(this);
}

@JsonSerializable()
class DifficultyLevel {
    @JsonKey(name: 'id')
    final String? id;
    @JsonKey(name: 'name')
    final String? name;

    DifficultyLevel({
        this.id,
        this.name,
    });

    DifficultyLevel copyWith({
        String? id,
        String? name,
    }) => 
        DifficultyLevel(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory DifficultyLevel.fromJson(Map<String, dynamic> json) => _$DifficultyLevelFromJson(json);

    Map<String, dynamic> toJson() => _$DifficultyLevelToJson(this);
}
