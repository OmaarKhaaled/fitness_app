import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ChatMessageModel extends HiveObject {
  @HiveField(0)
  final String role;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final bool isCached;

  ChatMessageModel({
    required this.role,
    required this.text,
    this.isCached = false,
  });

  ChatMessageModel copyWith({String? role, String? text, bool? isCached}) {
    return ChatMessageModel(
      role: role ?? this.role,
      text: text ?? this.text,
      isCached: isCached ?? this.isCached,
    );
  }
}
