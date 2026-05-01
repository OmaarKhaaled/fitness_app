import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ChatMessageModel extends HiveObject {
  @HiveField(0)
  final String role;

  @HiveField(1)
  final String text;

  ChatMessageModel({required this.role, required this.text});
}
