import 'package:fitness_app/features/smart_coach/data/models/chat_message.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class SessionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final List<ChatMessageModel> messages;

  SessionModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.messages,
  });
}
